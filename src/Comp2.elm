module Comp2 exposing (..)

import Comp exposing (Component, genComp)


type alias Data =
    String


update : Data -> Data
update x =
    x ++ "!"


initData : Data
initData =
    "Hello"


comp : Component
comp =
    genComp
        { init = initData
        , update = update
        , render = identity
        }
