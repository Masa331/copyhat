module Templates.Update exposing (..)

import Messages exposing (..)
import Models exposing (..)

update : TemplateMessage -> Model -> (Model, Cmd Msg)
update msg model =
  (model, Cmd.none)
