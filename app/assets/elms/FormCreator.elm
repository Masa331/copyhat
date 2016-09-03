--= depend_on Views
--= depend_on Messages
--= depend_on Models
--= depend_on Ports

module FormCreator exposing (..)

import Html.App exposing (..)
import String
import Task exposing (..)
import Http exposing (..)
import Rails exposing (..)
import Json.Decode exposing (..)
import Json.Encode exposing (..)
import Messages exposing (..)
import Models exposing (..)
import Views exposing (..)
import Mouse exposing (..)
import Ports exposing (..)


-- Updates --

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    FormSubmit -> formSubmit model
    FormSaved url -> formSaved model url
    FormFailed _ -> (model, Cmd.none)
    MouseClick newPosition -> getElementPositions model
    DragStart id -> updateDragStatus id model
    DragStop _ -> stopDragStatus model
    PositionReturned position -> updatePosition position model

getElementPositions : Model -> (Model, Cmd Msg)
getElementPositions model =
  ({ model | mouse_position = newPosition }, Cmd.none)


updatePosition : ElementPosition -> Model -> (Model, Cmd Msg)
updatePosition position model =
  (model, Cmd.none)


updateDragStatus : Int -> Model -> (Model, Cmd Msg)
updateDragStatus id model =
  let
    oldForm = model.form
    newInputs = List.map (\input -> if input.id == id then { input | being_dragged = True } else input ) oldForm.inputs
    newModel = { model | form = { oldForm | inputs = newInputs } }
  in
    (newModel, Cmd.none)

stopDragStatus : Model -> (Model, Cmd Msg)
stopDragStatus model =
  let
    oldForm = model.form
    newInputs = List.map (\input -> { input | being_dragged = False } ) oldForm.inputs
    newModel = { model | form = { oldForm | inputs = newInputs } }
  in
    (newModel, Cmd.none)

formSaved : Model -> String -> (Model, Cmd Msg)
formSaved model url =
  (model, redirect url)

formSubmit model =
  (model, Task.perform FormFailed FormSaved (Rails.post ({ success = successDecoder, failure = failureDecoder}) "/forms" (encodeFormInJson model.form)))

successDecoder =
  ("redirect" := Json.Decode.string)

failureDecoder =
  ("failure" := Json.Decode.string)

encodeFormInJson : Form -> Body
encodeFormInJson form =
  let
    name = Json.Encode.string form.name
    id = Json.Encode.int form.id
    inputs = Json.Encode.list (List.map (\input -> Json.Encode.object [("title", (Json.Encode.string input.title)), ("type", (Json.Encode.string (String.toLower (toString input.type'))))]) form.inputs)
  in
    Http.string (Json.Encode.encode 0 (Json.Encode.object [("name", name), ("id", id), ("inputs", inputs)]))


subscriptions : Model -> Sub Msg
subscriptions model =
  let
    clicks = Mouse.clicks MouseClick
    mouse_up = if elements_being_dragged model then Mouse.ups DragStop else Sub.none
    getPositons = getPosition PositionReturned
  in
    Sub.batch [clicks, mouse_up]

elements_being_dragged : Model -> Bool
elements_being_dragged model =
  List.any .being_dragged model.form.inputs

main =
  Html.App.program { init = init, view = view, update = update, subscriptions = subscriptions }
