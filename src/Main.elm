module Main exposing (..)

import Comp exposing (render, update)
import Html exposing (text)
import PortableComponents.PortableComp as PortableComp
import UserComp exposing (ComponentMsg(..), portableCompMsgDecoder, portableCompMsgEncoder)
import UserComponents.UserComp
import UserComponents.UserCompMsg as UserCompMsg


main =
    text showComponent


{-| An example showing how to manipulate a component

Expected result:

12 --> 13 --> 12; User defined --> User defined! --> User defined!!

-}
showComponent : String
showComponent =
    let
        -- Component custom initializations
        comp1_init_msg =
            PortableCompMsg <| PortableComp.Init <| PortableComp.InitDataT 12

        -- Component instance
        comp1_m =
            PortableComp.comp portableCompMsgDecoder portableCompMsgEncoder comp1_init_msg

        comp2_init_msg =
            UserCompMsg <| UserCompMsg.Init <| UserCompMsg.InitDataT "User defined"

        comp2_m =
            UserComponents.UserComp.comp comp2_init_msg
    in
    case ( comp1_m, comp2_m ) of
        ( Just comp1, Just comp2 ) ->
            let
                ( comp1_s2, msg ) =
                    update (PortableCompMsg PortableComp.Increase) comp1

                ( comp1_s3, msg2 ) =
                    update (PortableCompMsg PortableComp.Decrease) comp1_s2

                ( comp2_s2, msg3 ) =
                    update (UserCompMsg <| UserCompMsg.Append "!") comp2

                ( comp2_s3, msg4 ) =
                    update (UserCompMsg <| UserCompMsg.Append "!") comp2_s2
            in
            render comp1
                ++ " --> "
                ++ render comp1_s2
                ++ " --> "
                ++ render comp1_s3
                ++ "; "
                ++ render comp2
                ++ " --> "
                ++ render comp2_s2
                ++ " --> "
                ++ render comp2_s3

        _ ->
            ""
