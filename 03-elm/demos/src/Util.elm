module Util exposing (..)


type alias Player =
    { life : Int
    , power : Int
    }


type EnemyState
    = Normal
    | Cooldown
    | Spike


type alias Enemy =
    { life : Int
    , power : Int
    , state : EnemyState
    }


type DamageError
    = NoDamage
    | DamageBack Int


computeDamage : Player -> Enemy -> Result DamageError Int
computeDamage player enemy =
    case enemy.state of
        Normal ->
            Ok player.power

        Cooldown ->
            Err NoDamage

        Spike ->
            Err (DamageBack enemy.power)


maximum : List comparable -> Maybe comparable
maximum xs =
    case xs of
        [] ->
            Nothing

        [ x ] ->
            Just x

        x :: y :: ys ->
            Just (List.foldl max (max x y) ys)


getItem : Int -> List a -> Maybe a
getItem index lst =
    case ( lst, index ) of
        ( [], _ ) ->
            Nothing

        ( x :: _, 0 ) ->
            Just x

        ( _ :: xs, i ) ->
            getItem (i - 1) xs
