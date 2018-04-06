port module ElementPosition exposing (..)

import Html exposing (..) -- I get errors when this isn't imported

type alias Position = { x : Int
                      , y : Int
                      , width: Int
                      , height: Int
                      , top: Int
                      , right: Int
                      , bottom: Int
                      , left: Int
                      }

port getPosition : String -> Cmd msg
port determinedPositions : (Maybe Position -> msg) -> Sub msg
