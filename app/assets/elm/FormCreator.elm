module FormCreator exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import String
import Task exposing (..)
import Http exposing (..)
import Json.Decode exposing (..)

type InputType = Email | Text | Submit
type alias Input = { title: String, type': InputType, value: String, id: Int }
type alias Form = { name: String, inputs: List Input, id: Int }


type Msg = FormSubmit | InputUpdate Int String | FormSaved | FormFailed


init : (Form, Cmd Msg)
init =
  ({ name = "Prvni Formular",
     id = 1,
     inputs = [Input "Email" Email "" 1,
               Input "Name" Text "" 2,
               Input "Submit" Submit "" 3] },
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
  button [onClick FormSubmit, type' "submit", class "btn btn-primary"] [text submitInput.title]

update : Msg -> Form -> (Form, Cmd Msg)
update msg form =
  case msg of
    FormSubmit -> formSubmit form
    InputUpdate id value ->
      ({ form | inputs = List.map (inputUpdate id value) form.inputs}, Cmd.none)

inputUpdate : Int -> String -> Input -> Input
inputUpdate id value input =
  Input input.title input.type' (if input.id == id then value else input.value) input.id

formSubmit form =
  let
      url = "forms/ahoj"
  in
     (form, Task.perform FormSaved FormFailed (Http.get decodeResponse url))

decodeResponse =
  Json.at ["data", "info"] Json.string

main =
  Html.App.program { init = init, view = view, update = update, subscriptions = \_ -> Sub.none }
