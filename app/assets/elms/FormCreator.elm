--= depend_on Views
--= depend_on Messages
--= depend_on Models

port module FormCreator exposing (..)

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

port redirect : String -> Cmd msg

-- Model --

init : (Form, Cmd Msg)
init =
  ({ name = "Prvni hovno Formular",
     id = 1,
     errors = "",
     response = "",
     inputs = [Input "Email" Email "" 1,
               Input "Name;" Models.Text "" 2,
               Input "submit" Submit "" 3] },
   Cmd.none)


-- Updates --

update : Msg -> Form -> (Form, Cmd Msg)
update msg form =
  case msg of
    FormSubmit -> formSubmit form
    FormSaved url -> formSaved form url
    FormFailed error -> ({ form | errors = toString error }, Cmd.none)

formSaved : Form -> String -> (Form, Cmd Msg)
formSaved form url =
  ({ form | errors = "", response = url}, redirect url)

inputUpdate : Int -> String -> Input -> Input
inputUpdate id value input =
  Input input.title input.type' (if input.id == id then value else input.value) input.id

formSubmit form =
  (form, Task.perform FormFailed FormSaved (Rails.post ({ success = successDecoder, failure = failureDecoder}) "/forms" (encodeFormInJson form)))

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


main =
  Html.App.program { init = init, view = view, update = update, subscriptions = \_ -> Sub.none }
