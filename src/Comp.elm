module Comp exposing (..)


type Component
    = Unroll { update : () -> Component, render : () -> String }


type alias ComponentSetting a =
    { init : a
    , update : a -> a
    , render : a -> String
    }


genComp : ComponentSetting a -> Component
genComp concomp =
    let
        genCompRec comp =
            let
                updates () =
                    genCompRec (concomp.update comp)

                renders () =
                    concomp.render comp
            in
            Unroll
                { update = updates
                , render = renders
                }
    in
    genCompRec concomp.init


update : Component -> Component
update comp =
    case comp of
        Unroll cc ->
            cc.update ()

render: Component -> String
render comp =
    case comp of
        Unroll cc ->
            cc.render ()
