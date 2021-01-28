module Formula exposing (Element(..), StyledText(..), Text(..), Type, URL, view, viewElement, viewStyledText, viewText)

import Html exposing (..)
import Html.Attributes exposing (href)


type alias URL =
    String


type Text
    = Raw String
    | Link URL String


type StyledText
    = RawStyle Text
    | Bold Text
    | Italic Text


type Element
    = P (List StyledText)
    | Listing (List (List StyledText))
    | Decimal (List (List StyledText))
    | Headers Int Text


type alias Type =
    List Element


viewText : Text -> Html msg
viewText t =
    case t of
        Raw txt ->
            text txt

        Link url txt ->
            a [ href url ] [ text txt ]


viewStyledText : StyledText -> Html msg
viewStyledText styled =
    case styled of
        RawStyle txt ->
            viewText txt

        Bold txt ->
            strong [] [ viewText txt ]

        Italic txt ->
            em [] [ viewText txt ]


viewList : (List (Html.Attribute msg) -> List (Html msg) -> b) -> List (List StyledText) -> b
viewList parent constructs =
    List.map (\c -> li [] <| List.map viewStyledText c) constructs |> parent []


viewElement : Element -> Html msg
viewElement elem =
    case elem of
        P stxts ->
            List.map viewStyledText stxts |> p []

        Listing constructs ->
            viewList ul constructs

        Decimal constructs ->
            viewList ol constructs

        Headers hn txt ->
            let
                header =
                    case hn of
                        1 ->
                            h1

                        2 ->
                            h2

                        3 ->
                            h3

                        4 ->
                            h4

                        5 ->
                            h5

                        _ ->
                            h6
            in
            header [] [ viewText txt ]


view : List Element -> List (Html msg)
view elems =
    List.map viewElement elems
