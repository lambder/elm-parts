module Master exposing (Model, init, Msg, update, view) --where


import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)
import Dict 

import Nested
import Parts exposing (Indexed)


main : Program Never
main =
  App.program
    { init = init
    , subscriptions = always Sub.none
    , update = update
    , view = view
    }


-- MODEL


type alias Model =
  { bA : Nested.Model,
    bB : Nested.Model 
  }


init : (Model, Cmd Msg)
init =
  ( { bA = (fst Nested.init), bB = (fst Nested.init) }
  , Cmd.none
  )


-- UPDATE


type Msg
  = Reset
  | NestedMsg (Parts.Msg Model)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Reset ->
      init

    NestedMsg msg' -> 
      Parts.update NestedMsg msg' model




view : Model -> Html Msg
view model =
  div
    []
    [ Nested.render .bA (\m c -> {c | bA = m}) NestedMsg model
    , Nested.render .bB (\m c -> {c | bB = m}) NestedMsg model
    , button [ onClick Reset ] [ text "RESET" ]
    ]    


