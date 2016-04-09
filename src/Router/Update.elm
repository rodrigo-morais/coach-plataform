module Router.Update (..) where


import Hop.Navigate exposing (navigateTo)

import Effects exposing (Effects)


import Router.Actions exposing (..)
import Router.Models exposing (..)


update : Router.Actions.Action -> RouteModel -> (RouteModel, Effects Action)
update action model =
  case action of
    NavigateTo path ->
      ( model, Effects.map HopAction (navigateTo path) )

    HopAction () ->
      (model, Effects.none)

    ApplyRoute ( route, location ) ->
      ( { model | route = route, location = location }, Effects.none )