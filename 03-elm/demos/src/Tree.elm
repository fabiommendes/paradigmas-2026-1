module Tree exposing (..)


type Tree a
    = Leaf a
    | Node (Tree a) (Tree a)


member : a -> Tree a -> Bool
member x tree =
    case tree of
        Leaf y ->
            x == y

        Node left right ->
            member x left || member x right
