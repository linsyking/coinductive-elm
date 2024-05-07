module UserComponents.UserComp exposing (..)

import Comp exposing (Component(..), genComp)
import UserComp exposing (ComponentMsg(..))
import UserComponents.UserCompMsg as UserCompMsg exposing (Msg(..))


{-| Component specific data
-}
type alias Data =
    String


{-| Initializer
-}
initData : ComponentMsg -> Data
initData init =
    case decode init of
        Just (Init data) ->
            data.initVal

        _ ->
            ""


{-| Updater
-}
update : ComponentMsg -> Data -> ( Data, ComponentMsg )
update msg x =
    case decode msg of
        Just (Append y) ->
            ( x ++ y, OtherMsg )

        _ ->
            ( x, OtherMsg )


{-| Renderer
-}
render : Data -> String
render x =
    x


{-| Exported component
-}
comp : ComponentMsg -> Maybe (Component ComponentMsg)
comp =
    genComp
        { init = initData
        , update = update
        , render = render
        }
        (\x -> Just x)
        identity


decode : ComponentMsg -> Maybe UserCompMsg.Msg
decode msg =
    case msg of
        UserCompMsg m ->
            Just m

        _ ->
            Nothing
