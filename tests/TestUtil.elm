module TestUtil exposing (..)

import Expect
import Test exposing (..)


isEquals : String -> a -> a -> Test
isEquals str x y =
    test str <|
        \_ -> Expect.equal x y


isEqualsF : String -> (a -> b) -> a -> b -> Test
isEqualsF str f x y =
    isEquals str (f x) y


isNotEquals : String -> a -> a -> Test
isNotEquals str x y =
    test str <|
        \_ -> Expect.notEqual x y


isNotEqualsF : String -> (a -> b) -> a -> b -> Test
isNotEqualsF str f x y =
    isNotEquals str (f x) y
