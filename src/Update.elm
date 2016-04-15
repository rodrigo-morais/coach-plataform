module Update (..) where

import Effects exposing (Effects)


import Models exposing (..)
import Actions exposing (..)


import Coaches.Edit.Update
import Coaches.Search.Update
import Navigation.Update


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

    CoachesSearchAction subAction ->
      let
        ( updatedSearchVM, fx ) =
          Coaches.Search.Update.update subAction model.searchVM
      in
        ( { model | searchVM = updatedSearchVM }, Effects.map CoachesSearchAction fx )

    NavigationAction subAction ->
      let
        ( updatedSearchVM, fx ) =
          Navigation.Update.update subAction model
      in
        ( { model | searchVM = updatedSearchVM.searchVM }, Effects.map NavigationAction fx )

    RoutingAction subAction ->
      let
        (updateRouting, fx) =
          Routing.update subAction model.routeModel
      in
        ({ model | routeModel = updateRouting }, Effects.map RoutingAction fx)

    NoOp ->
      ( model, Effects.none )