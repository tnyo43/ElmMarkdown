module FormulaTest exposing (suite)

import Formula.Formula exposing (..)
import Html exposing (..)
import Html.Attributes exposing (href)
import Test exposing (..)
import TestUtil exposing (..)


suite : Test
suite =
    describe "Formula -> Html msg"
        [ describe "Styled -> Html msg"
            [ isEquals "Bold は strong タグ" (strong [] [ text "I'm strong!" ]) <| viewStyled (Bold "I'm strong!")
            , isEquals "Italic は em タグ" (em [] [ text "naname" ]) <| viewStyled (Italic "naname")
            ]
        , describe "Text -> Html msg"
            [ isEquals "Raw はただの text" (text "Hello") <| viewText (Raw <| RawStyle "Hello")
            , isEquals "Link は a タグ" (a [ href "my.site.jp" ] [ text "goto my site" ]) <| viewText (Link "my.site.jp" (RawStyle "goto my site"))
            , isEquals "Bold は中に a タグが入っても大丈夫" (a [ href "strong.link.com" ] [ strong [] [ text "I'm a strong link" ] ]) <| viewText (Link "strong.link.com" (Bold "I'm a strong link"))
            ]
        , describe "Element -> Html msg"
            [ isEquals
                "P タグは中のテキスト全てを囲む"
                (p []
                    [ text "I'm"
                    , strong [] [ text "Tomoya" ]
                    , text ". "
                    , a [ href "https://tnyo43.github.io/" ] [ em [] [ text "this is my page." ] ]
                    ]
                )
              <|
                viewElement
                    (P
                        [ Raw <| RawStyle "I'm"
                        , Raw <| Bold "Tomoya"
                        , Raw <| RawStyle ". "
                        , Link "https://tnyo43.github.io/" (Italic "this is my page.")
                        ]
                    )
            , isEquals
                "Lising は ul タグで li を囲む"
                (ul [] [ li [] [ text "No. 1" ], li [] [ text "second" ] ])
              <|
                viewElement (Listing [ [ Raw <| RawStyle "No. 1" ], [ Raw <| RawStyle "second" ] ])
            , isEquals
                "Lising は ol タグで li を囲む"
                (ol [] [ li [] [ text "No. 1" ], li [] [ text "second" ] ])
              <|
                viewElement (Decimal [ [ Raw <| RawStyle "No. 1" ], [ Raw <| RawStyle "second" ] ])
            , isEquals
                "Headers 1 は h1 タグ"
                (h1 [] [ text "header 1" ])
              <|
                viewElement (RawStyle "header 1" |> Raw |> Headers 1)
            ]
        ]
