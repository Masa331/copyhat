module Messages exposing (..)
import Rails exposing (..)
import Mouse exposing (..)

type alias ElementPosition = { x: Int }

type TemplateMessage = NoOp

type InputMessage
  = MouseClick Mouse.Position
  | DragStart Int
  | DragStop Mouse.Position
  | PositionReturned (ElementPosition)

type FormMessage
  = CreateForm
  | FormSaved String
  | FormFailed (Rails.Error String)


type Msg = FormMsg FormMessage | InputMsg InputMessage
