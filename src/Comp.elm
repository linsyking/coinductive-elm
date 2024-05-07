module Comp exposing (..)

{-|


# Component type, defined in a library, both component users and designers can use

-}


{-| a is the message type
-}
type Component a
    = Unroll { update : a -> Component a, render : () -> String }


{-| A concrete component before upcasting to the general component

We may add more functions to this type in the future. (For example, the getters)

-}
type alias ConcreteComponent a b =
    { init : a
    , update : b -> a -> a
    , render : a -> String
    }


{-| Generate a component from a concrete component

Use this when creating a component.

-}
genComp : ConcreteComponent a c -> (b -> Maybe c) -> Component b
genComp concomp transfer =
    let
        genCompRec comp =
            let
                updates msg =
                    let
                        transferred =
                            transfer msg
                    in
                    case transferred of
                        Nothing ->
                            genCompRec comp

                        Just ok_msg ->
                            genCompRec (concomp.update ok_msg comp)

                renders () =
                    concomp.render comp
            in
            Unroll
                { update = updates
                , render = renders
                }
    in
    genCompRec concomp.init


{-| Update a component. Component users should use this function to update a component.
-}
update : a -> Component a -> Component a
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
