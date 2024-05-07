module PortableComponents.PortableComp exposing (..)

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
initData : Msg -> Data
initData init =
    case init of
        Init data ->
            data.initVal

        _ ->
            0


{-| Component specific messages (interface)
-}
type Msg
    = Increase
    | Decrease
    | NoOp
    | Init InitDataT


{-| Updater
-}
update : Msg -> Data -> ( Data, Msg )
update msg x =
    case msg of
        Increase ->
            ( x + 1, NoOp )

        Decrease ->
            ( x - 1, NoOp )

        _ ->
            ( x, NoOp )


{-| Renderer
-}
render : Data -> String
render x =
    fromInt x


{-| Exported component
-}
comp : (a -> Maybe Msg) -> (Msg -> a) -> a -> Maybe (Component a)
comp =
    genComp
        { init = initData
        , update = update
        , render = render
        }
