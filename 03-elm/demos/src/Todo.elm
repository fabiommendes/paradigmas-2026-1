module Todo exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { todos : List String
    , input : String
    }


type Msg
    = AddTodoAddTAddTodoodo
    | UpdateInput String
    | DelTodo Int


init : Model
init =
    { todos = []
    , input = ""
    }


view : Model -> Html Msg
view m =
    div
        [ class "todo-app" ]
        [ css
        , input [ onInput UpdateInput, value m.input ] []
        , button [ onClick AddTodo ] [ text "+" ]
        , ul [ class "todo-list" ] (List.indexedMap viewTodo m.todos)
        ]


viewTodo : Int -> String -> Html Msg
viewTodo i txt =
    li [] [ text txt, button [ onClick (DelTodo i) ] [ text "-" ] ]


css : Html Msg
css =
    Html.node "style"
        []
        [ text """
        .todo-app {
            font-size: 2rem;
            font-family: "Comic Sans";
            color: magenta;
            padding: 2rem;
            background: cyan;
        }

        .todo-app button {
            color: white;
            background: black;
        }
        """
        ]


update : Msg -> Model -> Model
update msg m =
    case msg of
        AddTodo ->
            if m.input == "" then
                m

            else
                { input = ""
                , todos = m.input :: m.todos
                }

        UpdateInput value ->
            { m | input = value }

        DelTodo i ->
            { m
                | todos =
                    m.todos
                        |> List.indexedMap (\j x -> ( i /= j, x ))
                        |> List.filterMap
                            (\( cond, x ) ->
                                if cond then
                                    Just x

                                else
                                    Nothing
                            )
            }


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }
