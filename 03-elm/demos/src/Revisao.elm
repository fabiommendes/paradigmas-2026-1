module Revisao exposing (..)


todo =
    Debug.todo "..."


{-| Calcula o par do maior valor de uma função e seu argumento.

Modifique esta função para usar recursão de cauda ou fold.

def argMax(f, lst):
par = None
for x in lst:
value = f(x)
if par is None or pair[1] > value:
par = (x, value)
return par

-}
argMax : (a -> number) -> List a -> Maybe ( a, number )
argMax f xs =
    let
        run : Maybe ( a, number ) -> List a -> Maybe ( a, number )
        run acc lst =
            case lst of
                [] ->
                    acc

                y :: ys ->
                    run (maxAcc y acc) ys

        maxAcc : a -> Maybe ( a, number ) -> Maybe ( a, number )
        maxAcc x acc =
            case ( f x, acc ) of
                ( value, Nothing ) ->
                    Just ( x, value )

                ( value, Just ( y, value_ ) ) ->
                    if value > value_ then
                        Just ( x, value )

                    else
                        Just ( y, value_ )
    in
    run Nothing xs


{-| Calcula o par do maior valor de uma função e seu argumento.

Modifique esta função para usar recursão de cauda ou fold.

-}
argMax_ : (a -> number) -> List a -> Maybe ( a, number )
argMax_ f xs =
    case xs of
        [] ->
            Nothing

        head :: rest ->
            let
                value =
                    f head
            in
            case argMax_ f rest of
                Nothing ->
                    Just ( head, value )

                Just ( maxArg, maxValue ) ->
                    if value >= maxValue then
                        Just ( head, value )

                    else
                        Just ( maxArg, maxValue )
