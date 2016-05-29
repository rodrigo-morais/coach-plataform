module View (..) where


import Html exposing (..)


import Router.Models exposing (..)


import Router.Update exposing (..)


import Actions exposing (..)
import Models exposing (..)


import Coaches.Search.View as CoachesSearchView
import Coaches.Edit.View as CoachesEditView


import Coaches.Models as CoachesModels
import Coaches.Edit.Models as CoachesEditModels
import Coaches.Search.Models as CoachesSearchModels

import Navigation.View as NavigationView


view : Signal.Address Action -> AppModel -> Html.Html
view address model =
  div [ ]
      [ NavigationView.view model
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
  let
    updatedSearchVM =
      { model | searchVM = CoachesSearchModels.initialViewModel }

    isValid =
      (model.coachVM.coach.id == coachId)

  in
    if isValid then
      CoachesEditView.view (Signal.forwardTo address CoachesEditAction) model.configuration updatedSearchVM.coachVM
    else
      notFoundView 


coachesNewView : Signal.Address Action -> AppModel -> Html.Html
coachesNewView address model =
  CoachesEditView.view (Signal.forwardTo address CoachesEditAction) model.configuration model.coachVM


coachesSearchView : Signal.Address Action -> AppModel -> Html.Html
coachesSearchView address model =
  CoachesSearchView.view (Signal.forwardTo address CoachesSearchAction) model.configuration model.searchVM
