module Views exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Messages exposing (..)
import Models exposing (..)
import String

-- view : Model -> Html Msg
view model =
  div [class "row"] [inputTemplates, formGrid model]

-- inputTemplates : Html Msg
inputTemplates =
  div [class "col-sm-6"]
      [Html.form [] [div [class "form-group"]
                         [label [for "textInput"] [text "Text"],
                          input [type' "text", class "form-control", id "textInput", name "textInput"] []],
                     button [class "btn btn-primary"] [text "Stlac"]]]

-- formGrid : Model -> Html Msg
formGrid model =
  div [class "col-sm-6"]
      [ div [] [text (toString model.mouse_position)]
      , div [] [text (toString model.elementPosition)]
      , div [] [text (toString model.form.inputs)]
      , div [class "card card-block"]
            [h2 [] [text model.form.name]
            , Html.form [] (inputViews model)
            ]
      , div [] [a [href "#", onClick (FormMsg CreateForm)] [text "Vytvorit formular"]]
      ]

-- inputViews : Model -> List (Html Msg)
inputViews model =
  List.map inputView (List.sortBy .y_position model.form.inputs)


-- inputView : Input -> Html Msg
inputView myInput =
  case myInput.type' of
    Email -> baseInputView myInput
    Text -> baseInputView myInput
    Submit -> submitInputView myInput

-- baseInputView : Input -> Html Msg
baseInputView input =
  div [class "form-group draggable", id ("input-" ++ (toString input.id)), onMouseDown (InputMsg (DragStart input.id))]
      [label [for (inputIdentifier input)] [text input.title]
      , Html.input [type' (toString input.type')
                   , class "form-control"
                   , id (inputIdentifier input)
                   ] []
      ]


-- submitInputView : Input -> Html Msg
submitInputView submitInput =
  button [type' "submit", class "btn btn-primary"] [text submitInput.title]


inputIdentifier input =
  (String.toLower (toString input.type')) ++ (toString input.id)
