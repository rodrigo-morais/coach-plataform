module Navigation.Update (..) where


import Effects exposing (..)


import Navigation.Actions exposing (..)


import Models exposing (..)
import Coaches.Search.Models as CoachesSearchModels


update : Action -> AppModel -> (AppModel, Effects Action)
update action model =
  case action of
    NoOp ->
      (model, Effects.none)

    CleanSearchVM ->
      let
        updatedSearchVM =
          { model | searchVM = CoachesSearchModels.initialViewModel }
      in
        (updatedSearchVM, Effects.none)