module FormTest exposing (..)

import Html exposing (..)
import Html.App exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Task exposing (..)
import Http exposing (..)
import Rails exposing (..)
import Json.Decode exposing (..)

type alias Form = { info: String }
type Msg = FormSubmit | FormFailed (Rails.Error String) | FormSaved String


init : (Form, Cmd Msg)
init =
  ({ info = "nic" }, Cmd.none)

view : Form -> Html Msg
view form =
  div []
      [h2 [] [text "Test formular"],
       Html.form [onSubmit FormSubmit] [button [type' "submit", class "btn btn-primary"] [text "submit"]],
       text (toString form)]

update : Msg -> Form -> (Form, Cmd Msg)
update msg form =
  case msg of
    FormSubmit -> submitForm form
    FormFailed err -> (form, Cmd.none)
    FormSaved ok -> (form, Cmd.none)

submitForm form =
  -- (form, Cmd.none)
  -- (form, Task.perform FormFailed FormSaved (Rails.post decodeResponse "/forms" Http.empty))
  (form, Task.perform FormFailed FormSaved (Rails.post (Rails.always decodeResponse) "/forms" Http.empty))

decodeResponse =
  Json.Decode.string


main =
  Html.App.program { init = init, view = view, update = update, subscriptions = \_ -> Sub.none }
