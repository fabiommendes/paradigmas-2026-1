module Recursao exposing (..)

import Html



-- result = [];
-- for (let i = 1; i <= n; i = i + 1) {
--     result = [...result, i.toString()];
-- }


countTo : Int -> List String
countTo n =
    let
        loop : List String -> Int -> List String
        loop acc i =
            if i <= n then
                loop (String.fromInt i :: acc) (i + 1)

            else
                acc
    in
    loop [] 1 |> List.reverse

-- function fat (n) {
-- 	return (n == 0) ? 1 : (n * fat(n - 1));
-- };
fat : Int -> Int
fat n =
    if n == 0 then
        1

    else
        n * fat (n - 1)



-- acc = 1;
-- for (let i = n; i >= 0; i--) {
--     acc = i * acc;
-- }


fatTCO : Int -> Int
fatTCO n =
    let
        loop : Int -> Int -> Int
        loop acc i =
            if i == 0 then
                acc

            else
                loop (acc * i) (i - 1)
    in
    loop 1 n


main =
    let
        a =
            fat 5

        b =
            fatTCO 5
    in
    Html.text (String.fromInt a ++ String.fromInt b)
