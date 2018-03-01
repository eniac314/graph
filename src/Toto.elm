module Toto exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    Int


type Msg
    = Increase
    | Decrease
    | Default



--main : Pr


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


view : Model -> Html Msg
view model =
    div [ id "page" ]
        [ text ("nombre: " ++ toString model)
        , br [] []
        , button [ onClick Increase ] [ text "increase" ]
        , button [ onClick Decrease ] [ text "decrease" ]
        , img [ src "" ] []
        ]


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Increase ->
            ( model + 1, Cmd.none )

        Decrease ->
            ( model - 1, Cmd.none )

        Default ->
            ( model, Cmd.none )



--subscriptions : Model ->


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
