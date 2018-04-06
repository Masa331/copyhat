module Forms.Update exposing (..)

import Messages exposing (..)
-- import Messages exposing (Msg)
import Models exposing (..)
import Task exposing (..)
import Rails exposing (..)
import Json.Decode exposing (..)
import Json.Encode exposing (..)
import String
import Http exposing (..)

import Redirect exposing (..)

update msg model =
  case msg of
    Messages.CreateForm ->
      createForm model
    Messages.FormSaved url ->
      formSaved model url
    Messages.FormFailed _ ->
      (model, Cmd.none)

createForm model =
  -- (model, Task.perform FormFailed FormSaved (Rails.post ({ success = successDecoder, failure = failureDecoder}) "/forms" (encodeFormInJson model.form)))
  (model, Task.perform FormFailed FormSaved (Rails.post ({ success = successDecoder, failure = failureDecoder}) "/forms" (encodeFormInJson model.form)))

formSaved model url =
  (model, redirect url)

successDecoder =
  ("redirect" := Json.Decode.string)

failureDecoder =
  ("failure" := Json.Decode.string)

encodeFormInJson form =
  let
    name = Json.Encode.string form.name
    id = Json.Encode.int form.id
    inputs = Json.Encode.list (List.map (\input -> Json.Encode.object [("title", (Json.Encode.string input.title)), ("type", (Json.Encode.string (String.toLower (toString input.type'))))]) form.inputs)
  in
    Http.string (Json.Encode.encode 0 (Json.Encode.object [("name", name), ("id", id), ("inputs", inputs)]))
