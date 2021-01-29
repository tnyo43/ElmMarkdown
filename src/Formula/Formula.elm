module Formula.Formula exposing (Element(..), Styled(..), Text(..), Type, URL, view, viewElement, viewStyled, viewText)

import Html exposing (..)
import Html.Attributes exposing (href)


type Styled
    = RawStyle String
    | Bold String
    | Italic String


type alias URL =
    String


type Text
    = Raw Styled
    | Link URL Styled


type Element
    = P (List Text)
    | Listing (List (List Text))
    | Decimal (List (List Text))
    | Headers Int Text


type alias Type =
    List Element


viewStyled : Styled -> Html msg
viewStyled styled =
    case styled of
        RawStyle txt ->
            text txt

        Bold txt ->
            strong [] [ text txt ]

        Italic txt ->
            em [] [ text txt ]


viewText : Text -> Html msg
viewText t =
    case t of
        Raw txt ->
            viewStyled txt

        Link url txt ->
            a [ href url ] [ viewStyled txt ]


viewList : (List (Html.Attribute msg) -> List (Html msg) -> b) -> List (List Text) -> b
viewList parent constructs =
    List.map (\c -> li [] <| List.map viewText c) constructs |> parent []


viewElement : Element -> Html msg
viewElement elem =
    case elem of
        P txts ->
            List.map viewText txts |> p []

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
