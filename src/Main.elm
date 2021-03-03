module Main exposing (main)

import Browser
import Html exposing (..)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , view = view
        , update = update
        }


type Model
    = Raw String


init : Model
init =
    Raw ""


type Msg
    = MADANAIYO


update : Msg -> Model -> Model
update msg model =
    case msg of
        MADANAIYO ->
            model


view : Model -> Html Msg
view _ =
    div [] []
