module Option exposing (..)

{-
   Módulo Maybe usando as convenções de nome do Rust.
-}


type Option a
    = Some a
    | None


map : (a -> b) -> Option a -> Option b
map fn opt =
    case opt of
        None ->
            None

        Some x ->
            Some (fn x)


withDefault : a -> Option a -> a
withDefault value opt =
    case opt of
        None ->
            value

        Some x ->
            x


andThen : (a -> Option b) -> Option a -> Option b
andThen fn opt =
    case opt of
        None ->
            None

        Some x ->
            fn x


map2 : (a -> b -> c) -> Option a -> Option b -> Option c
map2 fn a b =
    case ( a, b ) of
        ( Some x, Some y ) ->
            Some (fn x y)

        _ ->
            None
