module Update (..) where

import Effects exposing (Effects)


import Models exposing (..)
import Actions exposing (..)


import Coaches.Edit.Update


import Router.Routing as Routing


update : Action -> AppModel -> ( AppModel, Effects Action )
update action model =
  case action of
    CoachesEditAction subAction ->
      let
        ( updatedCoachVM, fx ) =
          Coaches.Edit.Update.update subAction model.coachVM
      in
        ( { model | coachVM = updatedCoachVM }, Effects.map CoachesEditAction fx )

    RoutingAction subAction ->
      let
        (updateRouting, fx) =
          Routing.update subAction model.routeModel
      in
        ({ model | routeModel = updateRouting }, Effects.map RoutingAction fx)

    NoOp ->
      ( model, Effects.none )