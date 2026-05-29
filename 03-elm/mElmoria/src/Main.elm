module Main exposing (main)

import Array exposing (Array)
import Browser
import Card
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Msg exposing (Msg(..))
import Platform.Sub exposing (Sub)
import Random exposing (..)



-- import VitePluginHelper
-- img [ src <| VitePluginHelper.asset "/src/assets/logo.png", style "width" "300px" ] []


type GameState
    = NoCardClicked
    | OneCardShown Int
    | TwoCardsShown Int Int
    | Victory


type alias Model =
    { cards : Array Card.Model
    , state : GameState
    , seed : Seed
    }


main : Program Seed Model Msg
main =
    Browser.element
        { init =
            \seed ->
                let
                    _ = Debug.log "flag" seed
                    cards =
                        Card.initialCards

                    ( newSeed, newCards ) =
                        shuffle seed cards
                in
                ( { cards = Array.fromList newCards
                  , state = NoCardClicked
                  , seed = newSeed
                  }
                , Cmd.none
                )
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model.state ) of
        ( NoOp, _ ) ->
            model |> noCmd

        ( RestartGame, _ ) ->
            let
                ( newSeed, newCards ) =
                    shuffle model.seed Card.initialCards
            in
            { model
                | cards = Array.fromList newCards
                , state = NoCardClicked
                , seed = newSeed
            }
                |> noCmd

        ( _, Victory ) ->
            model |> noCmd

        ( CardClicked i, NoCardClicked ) ->
            let
                card =
                    Array.get i model.cards
                        |> Maybe.withDefault Card.empty
            in
            if card.state == Card.IsEmpty then
                model |> noCmd

            else
                { model
                    | state = OneCardShown i
                    , cards = mapItem Card.flip i model.cards
                }
                    |> noCmd

        ( CardClicked i, OneCardShown j ) ->
            let
                card =
                    Array.get i model.cards
                        |> Maybe.withDefault Card.empty
            in
            if i == j || card.state == Card.IsEmpty then
                model |> noCmd

            else
                { model
                    | state = TwoCardsShown i j
                    , cards = mapItem Card.flip i model.cards
                }
                    |> checkVictory
                    |> noCmd

        ( CardClicked k, TwoCardsShown i j ) ->
            let
                card1 =
                    Array.get i model.cards

                card2 =
                    Array.get j model.cards
            in
            if card1 == card2 then
                model
                    |> removePair ( i, j )
                    |> setState NoCardClicked
                    |> checkVictory
                    |> update (CardClicked k)

            else
                model
                    |> closeAllCards
                    |> setState NoCardClicked
                    |> update (CardClicked k)


view : Model -> Html Msg
view model =
    let
        victoryDialog =
            if model.state == Victory then
                div [ class "victory-dialog", onClick RestartGame ]
                    [ text "PARABÉNS"
                    ]

            else
                text ""
    in
    div []
        [ h1 [] [ text "Jogo da Memória" ]
        , div [ class "grid" ]
            (List.indexedMap Card.view
                (model.cards
                    |> Array.toList
                )
            )
        , victoryDialog
        ]


{-| Aplica a fn no i-esimo elemento do array, se existir
-}
mapItem : (a -> a) -> Int -> Array a -> Array a
mapItem fn i array =
    let
        elem =
            Array.get i array
    in
    case elem of
        Just x ->
            Array.set i (fn x) array

        Nothing ->
            array


removePair : ( Int, Int ) -> Model -> Model
removePair ( i, j ) model =
    { model
        | cards =
            model.cards
                |> mapItem Card.removeCard i
                |> mapItem Card.removeCard j
    }


closeAllCards : Model -> Model
closeAllCards model =
    { model | cards = Array.map Card.closeCard model.cards }


setState : GameState -> Model -> Model
setState state model =
    { model | state = state }


checkVictory : Model -> Model
checkVictory model =
    let
        reducer card cond =
            cond && card.state /= Card.IsClosed

        hasWon =
            Array.foldl reducer True model.cards
    in
    if hasWon then
        { model | state = Victory }

    else
        model


noCmd : m -> ( m, Cmd Msg )
noCmd m =
    ( m, Cmd.none )
