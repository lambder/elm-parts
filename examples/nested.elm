module Nested exposing (Model, init, Msg, update, view, render) --where


import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)
import Dict 

import Counter
import Parts exposing (Indexed)


--main : Program Never
--main =
--  App.program
--    { init = init
--    , subscriptions = always Sub.none
--    , update = update
--    , view = view       -- HOW DO I WRAP "view : (Msg -> msg) -> Model -> Html msg" so it is "view : Model -> Html msg" 
--    }


-- MODEL


type alias Model =
  { counterA : Counter.Model,
    counterB : Counter.Model 
  }


init : (Model, Cmd Msg)
init =
  ( { counterA = 0, counterB = 0 }
  , Cmd.none
  )


-- UPDATE


type Msg
  = Reset
  | CounterMsg (Parts.Msg Model)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Reset ->
      init

    CounterMsg msg' -> 
      Parts.update CounterMsg msg' model


-- VIEW
view : (Msg -> msg) -> Model -> Html msg
view lift model =
  div
    []
    [ Counter.render1 .counterA (\m c -> {c | counterA = m}) (lift << CounterMsg) model
    , Counter.render1 .counterB (\m c -> {c | counterB = m}) (lift << CounterMsg) model
    , button [ onClick (lift Reset) ] [ text "RESET" ]
    ]



render : Parts.Get Model c -> Parts.Set Model c -> (Parts.Msg c -> m) -> c -> Html m
render g s = 
  Parts.create1 view update g s 
