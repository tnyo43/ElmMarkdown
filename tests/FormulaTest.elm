module FormulaTest exposing (..)

import Formula exposing (..)
import Html exposing (..)
import Html.Attributes exposing (href)
import Test exposing (..)
import TestUtil exposing (..)


suite : Test
suite =
    describe "Formula -> Html msg"
        [ describe "Text -> Html msg"
            [ isEqualsF "Raw はただの text" viewText (Raw "Hello") (text "Hello")
            , isEqualsF "Link は a タグ" viewText (Link "my.site.jp" "goto my site") (a [ href "my.site.jp" ] [ text "goto my site" ])
            ]
        , describe "StyledText -> Html msg"
            [ isEqualsF "Bold は strong タグ" viewStyledText (Bold <| Raw "I'm strong!") (strong [] [ text "I'm strong!" ])
            , isEqualsF "Bold は中に a タグが入っても大丈夫" viewStyledText (Bold <| Link "strong.link.com" "I'm a strong link") (strong [] [ a [ href "strong.link.com" ] [ text "I'm a strong link" ] ])
            , isEqualsF "Italic は em タグ" viewStyledText (Italic <| Raw "naname") (em [] [ text "naname" ])
            ]
        , describe "Element -> Html msg"
            [ isEqualsF
                "P タグは中のテキスト全てを囲む"
                viewElement
                (P
                    [ RawStyle <| Raw "I'm"
                    , Bold <| Raw "Tomoya"
                    , RawStyle <| Raw ". "
                    , Italic <| Link "https://tnyo43.github.io/" "this is my page."
                    ]
                )
                (p []
                    [ text "I'm"
                    , strong [] [ text "Tomoya" ]
                    , text ". "
                    , em [] [ a [ href "https://tnyo43.github.io/" ] [ text "this is my page." ] ]
                    ]
                )
            , isEqualsF
                "Lising は ul タグで li を囲む"
                viewElement
                (Listing [ [ RawStyle <| Raw "No. 1" ], [ RawStyle <| Raw "second" ] ])
                (ul [] [ li [] [ text "No. 1" ], li [] [ text "second" ] ])
            , isEqualsF
                "Lising は ol タグで li を囲む"
                viewElement
                (Decimal [ [ RawStyle <| Raw "No. 1" ], [ RawStyle <| Raw "second" ] ])
                (ol [] [ li [] [ text "No. 1" ], li [] [ text "second" ] ])
            , isEqualsF
                "Headers 1 は h1 タグ"
                viewElement
                (Headers 1 <| Raw "header 1")
                (h1 [] [ text "header 1" ])
            ]
        ]
