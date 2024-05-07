module Comp exposing (..)

{-|


# Component type, defined in a library, both component users and designers can use

-}


{-| a is the message type
-}
type Component a
    = Unroll
        { update : a -> ( Component a, a )
        , render : () -> String
        }


{-| A concrete component before upcasting to the general component.
-}
type alias ConcreteComponent a b =
    { init : b -> a
    , update : b -> a -> ( a, b )
    , render : a -> String
    }


{-| Generate a component from a concrete component

Use this when creating a component.

-}
genComp : ConcreteComponent a c -> (b -> Maybe c) -> (c -> b) -> b -> Maybe (Component b)
genComp concomp decode encode initMsg =
    let
        genCompRec comp =
            let
                updates msg =
                    let
                        transferred =
                            decode msg
                    in
                    case transferred of
                        Nothing ->
                            ( genCompRec comp, msg )

                        Just ok_msg ->
                            let
                                ( new_comp, new_msg ) =
                                    concomp.update ok_msg comp
                            in
                            ( genCompRec new_comp, encode new_msg )

                renders () =
                    concomp.render comp
            in
            Unroll
                { update = updates
                , render = renders
                }
    in
    decode initMsg
        |> Maybe.andThen
            (\msg ->
                Just (genCompRec (concomp.init msg))
            )


{-| Update a component. Component users should use this function to update a component.
-}
update : a -> Component a -> ( Component a, a )
update msg comp =
    case comp of
        Unroll cc ->
            cc.update msg


{-| Render a component. Component users should use this function to render a component.
-}
render : Component a -> String
render comp =
    case comp of
        Unroll cc ->
            cc.render ()
