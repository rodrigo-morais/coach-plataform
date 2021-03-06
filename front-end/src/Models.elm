module Models (..) where


import Router.Models exposing (..)
import Coaches.Edit.Models as CoachesEditModels
import Coaches.Search.Models as CoachesSearchModels
import Configuration.Models exposing (Configuration, initialConfiguration)

type alias AppModel =
  { routeModel : RouteModel
  , coachVM : CoachesEditModels.ViewModel
  , searchVM : CoachesSearchModels.ViewModel
  , configuration : Configuration
  }


initialCoachEditVM : CoachesEditModels.ViewModel
initialCoachEditVM = CoachesEditModels.initialViewModel


initialAppModel : AppModel
initialAppModel =
  { routeModel = initialRouteModel
  , coachVM = CoachesEditModels.initialViewModel
  , searchVM = CoachesSearchModels.initialViewModel
  , configuration = initialConfiguration
  }