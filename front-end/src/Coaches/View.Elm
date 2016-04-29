module Coaches.View (..) where


import Html exposing (..)
import Html.Events exposing (on, targetValue)


onTextChange : Signal.Address a -> (String -> a) -> Attribute
onTextChange address action =
  let signalMessage str = 
    Signal.message address (action str)
  in
    on "change" targetValue (signalMessage) 
