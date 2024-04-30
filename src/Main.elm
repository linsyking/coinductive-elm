module Main exposing (..)

import Comp exposing (render, update)
import Comp1
import Comp2
import Html exposing (text)


main =
    text showComponent


allComponents : List Comp.Component
allComponents =
    [ Comp1.comp
    , Comp2.comp
    ]


showComponent : String
showComponent =
    List.foldl
        (\le str ->
            str
                ++ (render le ++ " --> " ++ render (update le))
                ++ ","
        )
        ""
        allComponents
