module Random exposing (..)


type alias Seed =
    Int


shuffle : Seed -> List a -> ( Seed, List a )
shuffle seed lst =
    let
        run acc items seed_ =
            case extractRandom seed_ items of
                ( newSeed, Just ( a, rest ) ) ->
                    run (a :: acc) rest newSeed

                ( newSeed, Nothing ) ->
                    ( newSeed, acc )

        extractRandom : Seed -> List a -> ( Seed, Maybe ( a, List a ) )
        extractRandom s xs =
            let
                ( seed_, index ) =
                    randIndex s (List.length xs)
            in
            ( seed_, extractAt index xs )

        extractAt : Int -> List a -> Maybe ( a, List a )
        extractAt n items =
            let
                rest =
                    List.drop n items

                start =
                    List.take n items
            in
            case rest of
                [] ->
                    Nothing

                x :: extra ->
                    Just ( x, start ++ extra )
    in
    run [] lst seed


{-| Retorna um índice entre 0 e n (não inclusive)
-}
randIndex : Seed -> Int -> ( Seed, Int )
randIndex seed n =
    let
        seed_ =
            nextSeed seed
    in
    if n == 0 then
        ( seed_, -1 )

    else
        ( seed_, seed_ |> modBy n )


nextSeed : Seed -> Seed
nextSeed x =
    (1664525 * x + 1013904223) |> modBy (2 ^ 32)
