module View (..) where


import Html exposing (..)


import Router.Models exposing (..)


import Actions exposing (..)
import Models exposing (..)


import Coaches.Search.View as CoachesSearchView
import Coaches.Edit.Edit as CoachesEditView
import Coaches.Edit.Models as CoachesEditModels


import Navigation.View as NavigationView


view : Signal.Address Action -> AppModel -> Html.Html
view address model =
  div [ ]
      [ NavigationView.view (Signal.forwardTo address NavigationAction) model
      , case model.routeModel.route of
          NotFoundRoute ->
            notFoundView
        
          CoachesEditRoute coachId ->
            coachesEditView address model coachId

          CoachesNewRoute ->
            coachesNewView address model

          CoachesSearchRoute ->
            coachesSearchView address model
      ]


notFoundView : Html.Html
notFoundView =
  div [ ]
      [ text "Not Found" ]


coachesEditView : Signal.Address Action -> AppModel -> CoachesEditModels.CoachId -> Html.Html
coachesEditView address model coachId =
  CoachesEditView.view (Signal.forwardTo address CoachesEditAction) model.coachVM


coachesNewView : Signal.Address Action -> AppModel -> Html.Html
coachesNewView address model =
  let
    updatedCoachVM =
      { model | coachVM = CoachesEditModels.initialViewModel }

  in
    CoachesEditView.view (Signal.forwardTo address CoachesEditAction) updatedCoachVM.coachVM


coachesSearchView : Signal.Address Action -> AppModel -> Html.Html
coachesSearchView address model =
  CoachesSearchView.view 
    (Signal.forwardTo address CoachesSearchAction) 
    model.searchVM
