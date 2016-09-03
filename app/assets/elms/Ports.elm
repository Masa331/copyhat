port module Ports exposing (..)
import Messages exposing (..)

port redirect : String -> Cmd msg
port getPosition : (ElementPosition -> msg) -> Sub msg
