module Card exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Msg exposing (..)


type CardState
    = IsClosed
    | IsOpen
    | IsEmpty


type alias Model =
    { content : String
    , state : CardState
    }


newCard : String -> Model
newCard content =
    { content = content, state = IsClosed }


initialCards : List Model
initialCards =
    [ newCard "A"
    , newCard "B"
    , newCard "C"
    , newCard "D"
    , newCard "E"
    , newCard "F"
    , newCard "G"
    , newCard "H"
    ]
        |> (\xs -> xs ++ xs)


empty : Model
empty =
    { content = "", state = IsEmpty }


view : Int -> Model -> Html Msg
view i card =
    div
        [ class (cardClass card.state)
        , onClick (CardClicked i)
        ]
        [ div [ class "card-content" ]
            [ text
                (if card.state == IsOpen then
                    card.content

                 else
                    ""
                )
            ]
        ]


cardClass : CardState -> String
cardClass state =
    case state of
        IsOpen ->
            "card"

        IsClosed ->
            "card card-closed"

        IsEmpty ->
            "card card-empty"


flip : Model -> Model
flip card =
    { card
        | state =
            case card.state of
                IsOpen ->
                    IsClosed

                IsClosed ->
                    IsOpen

                IsEmpty ->
                    IsEmpty
    }


removeCard : Model -> Model
removeCard model =
    { model | state = IsEmpty }


closeCard : Model -> Model
closeCard model =
    { model
        | state =
            if model.state == IsOpen then
                IsClosed

            else
                model.state
    }
