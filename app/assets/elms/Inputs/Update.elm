module Inputs.Update exposing (..)

import Mouse exposing (..)
import Messages exposing (..)
-- import Messages exposing (Msg)
import Models exposing (..)

update msg model =
  case msg of
    Messages.MouseClick newPosition ->
      getElementPositions model newPosition
    Messages.DragStart id ->
      updateDragStatus id model
    Messages.DragStop _ ->
      stopDragStatus model
    Messages.PositionReturned position ->
      updatePosition position model


getElementPositions model newPosition =
  ({ model | mouse_position = newPosition }, Cmd.none)

updatePosition position model =
  (model, Cmd.none)

updateDragStatus id model =
  let
    oldForm = model.form
    newInputs = List.map (\input -> if input.id == id then { input | being_dragged = True } else input ) oldForm.inputs
    newModel = { model | form = { oldForm | inputs = newInputs } }
  in
    (newModel, Cmd.none)

stopDragStatus model =
  let
    oldForm = model.form
    newInputs = List.map (\input -> { input | being_dragged = False } ) oldForm.inputs
    newModel = { model | form = { oldForm | inputs = newInputs } }
  in
    (newModel, Cmd.none)

elements_being_dragged model =
  List.any .being_dragged model.form.inputs
