module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Models exposing (..)
import String

view : Form -> Html Msg
view form =
  div [class "row"] [inputTemplates, formGrid form]

inputTemplates : Html Msg
inputTemplates =
  div [class "col-sm-6"]
      [Html.form [] [div [class "form-group"]
                         [label [for "textInput"] [text "Text"],
                          input [type' "text", class "form-control", id "textInput", name "textInput"] []],
                     -- button [class "btn btn-primary"] [text "push"]]]
                     button [class "btn btn-primary"] [text "hoven"]]]

formGrid : Form -> Html Msg
formGrid form =
  div [class "col-sm-6"] [h2 [] [text form.name],
                          Html.form [onSubmit FormSubmit] (List.map inputView form.inputs)]

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


submitInputView : Input -> Html msg
submitInputView submitInput =
  button [type' "submit", class "btn btn-primary"] [text submitInput.title]


inputIdentifier input =
  (String.toLower (toString input.type')) ++ (toString input.id)
