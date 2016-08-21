module Messages exposing (..)
import Rails exposing (..)

type Msg = FormSubmit | InputUpdate Int String | FormSaved String | FormFailed (Rails.Error String)
