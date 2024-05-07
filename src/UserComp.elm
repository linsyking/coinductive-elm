module UserComp exposing (..)

import PortableComponents.PortableComp
import UserComponents.UserCompMsg as UserCompMsg


{-| User defined component message type
-}
type ComponentMsg
    = PortableCompMsg PortableComponents.PortableComp.Msg
    | UserCompMsg UserCompMsg.Msg
    | OtherMsg


{-| Transfer function: From user defined message to component self-defined message
-}
portableCompMsgDecoder : ComponentMsg -> Maybe PortableComponents.PortableComp.Msg
portableCompMsgDecoder msg =
    case msg of
        PortableCompMsg m ->
            Just m

        _ ->
            Nothing


portableCompMsgEncoder : PortableComponents.PortableComp.Msg -> ComponentMsg
portableCompMsgEncoder _ =
    OtherMsg
