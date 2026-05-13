module ListAlt exposing (..)


type ListAlt a
    = Empty
    | Cons a (ListAlt a)


fromList : List a -> ListAlt a
fromList xs =
    case xs of
        [] ->
            Empty

        y :: ys ->
            Cons y (fromList ys)


toString : (a -> String) -> ListAlt a -> String
toString stringfy xs =
    let
        run : ListAlt a -> String
        run ys =
            case ys of
                Empty ->
                    ""

                Cons head tail ->
                    stringfy head ++ ", " ++ run tail

        inner =
            run xs |> stripComma
    in
    "[ " ++ inner ++ " ]"


map : (a -> b) -> ListAlt a -> ListAlt b
map fn lst =
    case lst of
        Empty ->
            Empty

        Cons x xs ->
            Cons (fn x) (map fn xs)


foldl : (a -> b -> b) -> b -> ListAlt a -> b
foldl fn seed lst =
    case lst of
        Empty ->
            seed

        Cons x xs ->
            foldl fn (fn x seed) xs


stripComma : String -> String
stripComma str =
    if String.endsWith ", " str then
        String.slice 0 -2 str

    else
        str
