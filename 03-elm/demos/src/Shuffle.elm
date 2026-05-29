module Shuffle exposing (Seed, rand, randIndex, randList, seed, shuffle, pickAt, pick)


type Seed
    = SeedValue Int


a =
    1664525


c =
    1013904223


m =
    2 ^ 32


seed : Int -> Seed
seed n =
    SeedValue (1000000 * (n + 1))


getSeed : Seed -> Int
getSeed (SeedValue n) =
    n


nextSeed : Seed -> Seed
nextSeed (SeedValue n) =
    SeedValue ((a * n + c) |> modBy m)


{-| Gera um numero aleatorio entre 0 e 1
-}
rand : Seed -> ( Float, Seed )
rand rng =
    let
        newSeed =
            nextSeed rng
    in
    ( toFloat (getSeed newSeed) / m, newSeed )


randIndex : Seed -> Int -> ( Int, Seed )
randIndex rng n =
    let
        ( x, seed_ ) =
            rand rng
    in
    ( toFloat n * x |> truncate, seed_ )


randList : Seed -> Int -> ( List Float, Seed )
randList rng n =
    if n <= 0 then
        ( [], rng )

    else
        let
            ( x, newSeed ) =
                rand rng
        in
        randList newSeed (n - 1)
            |> Tuple.mapFirst (\lst -> x :: lst)


shuffle : Seed -> List a -> ( List a, Seed )
shuffle rng lst =
    let
        loop acc xs initSeed =
            case pick initSeed xs of
                ( Nothing, finalSeed ) ->
                    ( acc, finalSeed )

                ( Just ( y, ys ), finalSeed ) ->
                    loop (y :: acc) ys finalSeed
    in
    loop [] lst rng


pick : Seed -> List a -> ( Maybe ( a, List a ), Seed )
pick rng lst =
    let
        length =
            List.length lst

        ( n, rng_ ) =
            randIndex rng length
    in
    ( pickAt n lst, rng_ )


pickAt : Int -> List a -> Maybe ( a, List a )
pickAt n lst =
    let
        start =
            List.take n lst

        rest =
            List.drop n lst
    in
    case rest of
        [] ->
            Nothing

        x :: xs ->
            Just ( x, start ++ xs )


