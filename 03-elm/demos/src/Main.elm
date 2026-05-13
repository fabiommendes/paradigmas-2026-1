module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    Int


type Msg
    = Incr
    | Decr
    | Reset


init : Model
init =
    0


view : Model -> Html Msg
view m =
    div
        [ class "counter" ]
        [ button [ onClick Decr ] [ text "-" ]
        , text (String.fromInt m)
        , button [ onClick Incr ] [ text "+" ]
        , button [ onClick Reset ] [ text "reset" ]
        ]


update : Msg -> Model -> Model
update msg m =
    if msg == Decr then
        m - 1
    else if msg == Incr then
        m + 1
    else
        0


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
