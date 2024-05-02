module Main exposing (..)

import Comp exposing (render, update)
import Comp1
import Html exposing (text)


main =
    text showComponent


{-| User defined component message type
-}
type ComponentMsg
    = Comp1Msg Comp1.Msg
    | BlahBlah


{-| Transfer function: From user defined message to component self-defined message
-}
comp1MsgTranslator : ComponentMsg -> Maybe Comp1.Msg
comp1MsgTranslator msg =
    case msg of
        Comp1Msg m ->
            Just m

        _ ->
            Nothing


{-| An example showing how to manipulate a component

Expected result:

12 --> 13 --> 12

-}
showComponent : String
showComponent =
    let
        -- Component custom initializations
        comp1_init =
            Comp1.InitDataT 12

        -- Component instance
        comp1 =
            Comp1.comp comp1_init comp1MsgTranslator

        comp1_s2 =
            update (Comp1Msg Comp1.Increase) comp1

        comp1_s3 =
            update (Comp1Msg Comp1.Decrease) comp1_s2
    in
    render comp1 ++ " --> " ++ render comp1_s2 ++ " --> " ++ render comp1_s3
