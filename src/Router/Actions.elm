module Router.Actions (..) where


import Hop.Types exposing (Location)
import Router.Models exposing (..)


type Action
  = ApplyRoute ( Route, Location )
  | HopAction()
  | NavigateTo String
