module UserComponents.UserCmpGlobal exposing (..)

import UserComp exposing (ComponentMsg(..))
import UserComponents.UserCompMsg as UserCompMsg


userCompMsgDecoder : ComponentMsg -> Maybe UserCompMsg.Msg
userCompMsgDecoder msg =
    case msg of
        UserCompMsg m ->
            Just m

        _ ->
            Nothing
