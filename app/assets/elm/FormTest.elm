module FormCreator exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

type InputType = Email | Text | Submit
type alias Input = { title: String, type': InputType }
type alias Form = { name: String, inputs: List Input, info: String }
type Msg = FormSubmit


init : (Form, Cmd Msg)
init =
  ({ name = "Prvni Formular",
    inputs = [Input "Email" Email,
              Input "Submit" Submit],
    info = "nic" },
   Cmd.none)

view : Form -> Html Msg
view myForm =
  div []
      [h2 [] [text myForm.name],
       Html.form [onSubmit FormSubmit]
                 [input [type' "text", class "form-control", id "emailInput"] [],
                  button [type' "submit", class "btn btn-primary"] [text "submit"]],
       text myForm.info]

update : Msg -> Form -> (Form, Cmd Msg)
update msg myForm =
  case msg of
    FormSubmit -> ({ myForm | info = "ahoj" }, Cmd.none)

subscriptions model =
  Sub.none

main =
  Html.App.program { init = init, view = view, update = update, subscriptions = subscriptions }
