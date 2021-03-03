module Formula.Parser exposing (..)

import Formula.Formula exposing (..)
import Parser exposing (..)
import Pratt exposing (..)
import Set


textParser : Parser Text
textParser =
    map (Raw << RawStyle) <|
        variable
            { start = \_ -> True
            , inner = \_ -> True
            , reserved = Set.empty
            }


elementParser : Parser Element
elementParser =
    oneOf
        [
            textParser
        ]


parseText : String -> Result (List DeadEnd) Text
parseText =
    run textParser
