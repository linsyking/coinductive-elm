module Comp1 exposing (..)

import Comp exposing (Component(..), genComp)
import String exposing (fromInt)


type alias Data =
    Int


initData : Data
initData =
    1


update : Data -> Data
update x =
    x + 1


comp : Component
comp =
    genComp
        { init = initData
        , update = update
        , render = fromInt
        }
