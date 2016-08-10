module FormCreator exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Task exposing (..)
import Http exposing (..)
import Rails exposing (..)
import Json.Decode exposing (..)
import Json.Encode exposing (..)
import Array exposing (..)
import List exposing (..)

type InputType = Email | Text | Submit
type alias Input = { title: String, type': InputType, value: String, id: Int }
type alias Form = { name: String, inputs: List Input, id: Int, errors: String, response: String }


type Msg = FormSubmit | InputUpdate Int String | FormSaved String | FormFailed (Rails.Error String)


init : (Form, Cmd Msg)
init =
  ({ name = "Prvni Formular",
     id = 1,
     errors = "",
     response = "",
     inputs = [Input "Email" Email "" 1,
               Input "Name;" Text "" 2,
               Input "submit" Submit "" 3] },
   Cmd.none)

view : Form -> Html Msg
view myForm =
  div [] [h2 [] [text myForm.name],
          Html.form [onSubmit FormSubmit] (List.map inputView myForm.inputs),
          text (toString myForm)]

inputView : Input -> Html Msg
inputView myInput =
  case myInput.type' of
    Email -> baseInputView myInput
    Text -> baseInputView myInput
    Submit -> submitInputView myInput

baseInputView : Input -> Html Msg
baseInputView input =
  div [class "form-group"]
      [label [for (inputIdentifier input)] [text input.title],
       Html.input [type' (toString input.type'),
                   class "form-control",
                   id (inputIdentifier input),
                   onInput (InputUpdate input.id)]
                  []]

inputIdentifier input =
  (String.toLower (toString input.type')) ++ (toString input.id)


submitInputView : Input -> Html msg
submitInputView submitInput =
  button [type' "submit", class "btn btn-primary"] [text submitInput.title]

update : Msg -> Form -> (Form, Cmd Msg)
update msg form =
  case msg of
    FormSubmit -> formSubmit form
    InputUpdate id value ->
      ({ form | inputs = List.map (inputUpdate id value) form.inputs}, Cmd.none)
    FormSaved _ -> (form, Cmd.none)
    FormFailed error -> ({ form | errors = toString error }, Cmd.none)

inputUpdate : Int -> String -> Input -> Input
inputUpdate id value input =
  Input input.title input.type' (if input.id == id then value else input.value) input.id

formSubmit form =
  (form, Task.perform FormFailed FormSaved (Rails.post (Rails.always decodeResponse) "/forms" (encodeFormInJson form)))

decodeResponse =
  Json.Decode.string

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
