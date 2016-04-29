module Coaches.Search.Update (..) where

import Coaches.Search.Actions exposing (..)
import Coaches.Search.Models exposing (..)
import Coaches.Search.Effects as SearchEffects

import Effects


update : Action -> ViewModel -> (ViewModel, Effects.Effects Action)
update action model =
  case action of
    SearchCoaches -> (model, SearchEffects.doSearch model)
    
    SearchDone result -> 
      case result of
          Ok coaches ->
            ({ model | coaches = coaches }, Effects.none)

          Err error ->
            (model, Effects.none)

    UpdateCapabilities value ->
      ({model | capabilities = value}, Effects.none)

    UpdateCoach value ->
      ({model | coach = value}, Effects.none)

    UpdateMentor value ->
      ({model | mentor = value}, Effects.none)

    SelectCoach coachId ->
      let
        getCoach =
          model.coaches
            |>  List.filter (\coach -> coach.id == coachId)
            |> List.head

      in
        case getCoach of
          Just coach ->
            let
              selectedCoach =
                model.selectedCoach

              updateSelectedCoach =
                { selectedCoach | coach = coach, editable = True }

              updatedCoach =
                { model | selectedCoach = updateSelectedCoach }

            in
              (updatedCoach, Effects.none)

          Nothing ->
            (model, Effects.none)

    ViewCoach coachId ->
      let
        (vm, fx) =
          update (SelectCoach coachId) model

        selectedCoach =
          vm.selectedCoach

        updatedSelectedCoach =
          { selectedCoach | editable = False}

      in
        ({ model | selectedCoach = updatedSelectedCoach }, Effects.none)

    NoOp -> (model, Effects.none)