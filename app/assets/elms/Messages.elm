module Messages exposing (..)
import Rails exposing (..)
import Mouse exposing (..)

type alias ElementPosition = { x: Int }

type Msg = FormSubmit
         | FormSaved String
         | FormFailed (Rails.Error String)
         | MouseClick Mouse.Position
         | DragStart Int
         | DragStop Mouse.Position
         | PositionReturned (ElementPosition)
