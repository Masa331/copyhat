module Messages exposing (..)
import Rails exposing (..)

type Msg = FormSubmit | FormSaved String | FormFailed (Rails.Error String)
