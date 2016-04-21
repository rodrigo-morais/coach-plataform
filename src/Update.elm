module Update (..) where

import Effects exposing (Effects)


import Array


import Models exposing (..)
import Actions exposing (..)


import Coaches.Edit.Update
import Coaches.Search.Update


import Coaches.Edit.Models as CoachesEditModels
import Coaches.Search.Models as CoachesSearchModels


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

        coachVM =
          model.coachVM

        selectedCoach =
          updatedSearchVM.selectedCoach

        updatedCoachVm =
          { coachVM | coach = selectedCoach.coach, editable = selectedCoach.editable }

      in
        ( { model | searchVM = updatedSearchVM, coachVM = updatedCoachVm }, Effects.map CoachesSearchAction fx )

    RoutingAction subAction ->
      let
        maybeClean =
          Array.get 1 (Array.fromList updateRouting.location.path)

        (coachVM, searchVM) =
          case maybeClean of
            Just "new" ->
              (CoachesEditModels.initialViewModel, CoachesSearchModels.initialViewModel)

            Just "search" ->
              (CoachesEditModels.initialViewModel, CoachesSearchModels.initialViewModel)

            Just _ ->
              (model.coachVM, model.searchVM)

            Nothing ->
              (model.coachVM, model.searchVM)

        (updateRouting, fx) =
          Routing.update subAction model.routeModel
      in
        ({ model | routeModel = updateRouting, coachVM = coachVM, searchVM = searchVM }, Effects.map RoutingAction fx)

    NoOp ->
      ( model, Effects.none )
