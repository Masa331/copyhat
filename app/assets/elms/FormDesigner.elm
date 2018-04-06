--= depend_on Views
--= depend_on Messages
--= depend_on Models
--= depend_on ElementPosition

module FormDesigner exposing (..)

import Html.App exposing (..)
-- import String
-- import Task exposing (..)
-- import Http exposing (..)
-- import Rails exposing (..)
-- import Json.Decode exposing (..)
-- import Json.Encode exposing (..)
import Messages exposing (..)
import Models exposing (..)
import Views exposing (..)
import Mouse exposing (..)
-- import Ports exposing (..)
import ElementPosition exposing (..)

import Forms.Update
import Inputs.Update
import Templates.Update


-- Updates --

-- update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    FormMsg formMsg ->
      Forms.Update.update formMsg model
    InputMsg inputMsg ->
      Inputs.Update.update inputMsg model
    -- TemplateMsg templteMsg ->
    --   Templates.Update update msg model

-- subscriptions : Model -> Sub Msg
-- subscriptions model =
--   let
--     clicks = Mouse.clicks MouseClick
--     mouse_up = if elements_being_dragged model then Mouse.ups DragStop else Sub.none
--     -- getPositons = getPosition PositionReturned
--   in
--     Sub.batch [clicks, mouse_up]

subscriptions model =
  Sub.none

main =
  Html.App.program { init = init, view = view, update = update, subscriptions = subscriptions }
