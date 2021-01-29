module FormulaTest exposing (..)

import Formula.Formula exposing (..)
import Html exposing (..)
import Html.Attributes exposing (href)
import Test exposing (..)
import TestUtil exposing (..)


suite : Test
suite =
    describe "Formula -> Html msg"
        [ describe "Text -> Html msg"
            [ isEquals "Raw はただの text" (text "Hello") <| viewText (Raw "Hello")
            , isEquals "Link は a タグ" (a [ href "my.site.jp" ] [ text "goto my site" ]) <| viewText (Link "my.site.jp" "goto my site")
            ]
        , describe "StyledText -> Html msg"
            [ isEquals "Bold は strong タグ" (strong [] [ text "I'm strong!" ]) <| viewStyledText (Bold <| Raw "I'm strong!")
            , isEquals "Bold は中に a タグが入っても大丈夫" (strong [] [ a [ href "strong.link.com" ] [ text "I'm a strong link" ] ]) <| viewStyledText (Bold <| Link "strong.link.com" "I'm a strong link")
            , isEquals "Italic は em タグ" (em [] [ text "naname" ]) <| viewStyledText (Italic <| Raw "naname")
            ]
        , describe "Element -> Html msg"
            [ isEquals
                "P タグは中のテキスト全てを囲む"
                (p []
                    [ text "I'm"
                    , strong [] [ text "Tomoya" ]
                    , text ". "
                    , em [] [ a [ href "https://tnyo43.github.io/" ] [ text "this is my page." ] ]
                    ]
                )
              <|
                viewElement
                    (P
                        [ RawStyle <| Raw "I'm"
                        , Bold <| Raw "Tomoya"
                        , RawStyle <| Raw ". "
                        , Italic <| Link "https://tnyo43.github.io/" "this is my page."
                        ]
                    )
            , isEquals
                "Lising は ul タグで li を囲む"
                (ul [] [ li [] [ text "No. 1" ], li [] [ text "second" ] ])
              <|
                viewElement (Listing [ [ RawStyle <| Raw "No. 1" ], [ RawStyle <| Raw "second" ] ])
            , isEquals
                "Lising は ol タグで li を囲む"
                (ol [] [ li [] [ text "No. 1" ], li [] [ text "second" ] ])
              <|
                viewElement (Decimal [ [ RawStyle <| Raw "No. 1" ], [ RawStyle <| Raw "second" ] ])
            , isEquals
                "Headers 1 は h1 タグ"
                (h1 [] [ text "header 1" ])
              <|
                viewElement (Headers 1 <| Raw "header 1")
            ]
        ]
