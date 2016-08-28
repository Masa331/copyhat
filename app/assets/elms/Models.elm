module Models exposing (..)

type InputType = Email | Text | Submit

type alias Input = { title: String, type': InputType, value: String, id: Int }

type alias Form = { name: String, inputs: List Input, id: Int, errors: String, response: String }

type alias Model = { form: Form, 
