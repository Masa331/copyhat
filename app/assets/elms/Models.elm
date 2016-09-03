module Models exposing (..)

import Mouse exposing (..)
import Messages exposing (..)

type InputType = Email | Text | Submit
type alias Input = { title: String, type': InputType, id: Int, y_position: Int, being_dragged: Bool }
type alias Form = { name: String, inputs: List Input, id: Int }

type alias Model = { form: Form
                   , mouse_position: Mouse.Position
                   , elementPosition: ElementPosition }

init : (Model, Cmd Msg)
init =
  ({ mouse_position = { x = 0, y = 0 }
   , form = starterForm
   , elementPosition = blankPosition
   }, Cmd.none)

starterForm : Form
starterForm =
  { name = "Prvni hovno Formular",
    id = 1,
    inputs = [Input "Email" Email 1 1 False, Input "Name;" Text 2 2 False, Input "submit" Submit 3 3 False] }

blankPosition : ElementPosition
blankPosition =
  { x = 0 }

