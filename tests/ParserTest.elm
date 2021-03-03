module ParserTest exposing (testParse)

import Formula.Formula exposing (..)
import Formula.Parser exposing (..)
import Parser exposing (DeadEnd)
import Test exposing (..)
import TestUtil exposing (..)


testParse : (String -> Result (List DeadEnd) a) -> String -> a -> String -> Test
testParse parse str expected raw =
    isEquals str (Ok expected) (parse raw)


suite : Test.Test
suite =
    describe "Bold, Italic, Link は後回し、無理"
        [ describe "Text -> Html msg"
            [ testParse parseText "普通の文はそのまま" (Raw <| RawStyle "こんにちは") "こんにちは"
            ]
        , describe "Element -> Html msg"
            [ testParse parseElement "空改行を挟まない文章は一つの P タグ" (P [ Raw <| RawStyle "こんにちは" ]) [ "こんにちは" ] ]
        ]
