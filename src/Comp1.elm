module Comp1 exposing (..)

import Comp exposing (Component(..), genComp)
import String exposing (fromInt)


{-| Component specific data
-}
type alias Data =
    Int


{-| Component specific initialization (constructor)
-}
type alias InitDataT =
    { initVal : Int
    }


{-| Initializer
-}
initData : InitDataT -> Data
initData init =
    init.initVal


{-| Component specific messages (interface)
-}
type Msg
    = Increase
    | Decrease


{-| Updater
-}
update : Msg -> Data -> Data
update msg x =
    case msg of
        Increase ->
            x + 1

        Decrease ->
            x - 1


{-| Renderer
-}
render : Data -> String
render x =
    fromInt x


{-| Exported component
-}
comp : InitDataT -> (a -> Maybe Msg) -> Component a
comp init =
    genComp
        { init = initData init
        , update = update
        , render = render
        }
