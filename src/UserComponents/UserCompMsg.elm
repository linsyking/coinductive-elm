module UserComponents.UserCompMsg exposing (..)

{-| Component specific messages (interface)
-}


type Msg
    = Append String
    | NoOp
    | Init InitDataT


{-| Component specific initialization (constructor)
-}
type alias InitDataT =
    { initVal : String
    }
