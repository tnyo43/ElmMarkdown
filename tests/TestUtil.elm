module TestUtil exposing (..)

import Expect
import Test exposing (..)


isEquals : String -> a -> a -> Test
isEquals str expected actual =
    test str <|
        \_ -> Expect.equal expected actual


isNotEquals : String -> a -> a -> Test
isNotEquals str notExpected actual =
    test str <|
        \_ -> Expect.notEqual notExpected actual
