module View (..) where


import Html exposing (..)


import Router.Models exposing (..)


import Actions exposing (..)
import Models exposing (..)


import Coaches.Edit.Edit as CoachesEditView
import Coaches.Edit.Models as CoachesEditModels


view : Signal.Address Action -> AppModel -> Html.Html
view address model =
  case model.routeModel.route of
    NotFoundRoute ->
      notFoundView
  
    CoachesEditRoute coachId ->
      coachesEditView address model.coaches coachId

    CoachesNewRoute ->
      coachesNewView address

notFoundView : Html.Html
notFoundView =
  div [ ]
      [ text "Not Found" ]


coachesEditView : Signal.Address Action -> List CoachesEditModels.Coach -> CoachesEditModels.CoachId -> Html.Html
coachesEditView address coaches coachId =
  let
    maybeCoach =
      coaches
      |> List.filter (\coach -> coach.id == coachId)
      |> List.head
  in
    case maybeCoach of
      Just coach ->
        let
          viewModel = 
            {
              coach = coach
            , message = CoachesEditModels.initialMessage
            }
        in
          CoachesEditView.view (Signal.forwardTo address CoachesEditAction) viewModel

      Nothing ->
        notFoundView


coachesNewView : Signal.Address Action -> Html.Html
coachesNewView address =
  let
    viewModel =
      {
        coach = CoachesEditModels.initialCoach
      , message = CoachesEditModels.initialMessage
      }

  in
    CoachesEditView.view (Signal.forwardTo address CoachesEditAction) viewModel