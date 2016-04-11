module Models (..) where


import Router.Models exposing (..)
import Coaches.Edit.Models as CoachesEditModels
import Coaches.Search.Models as CoachesSearchModels

type alias AppModel =
  { routeModel : RouteModel
  , coaches : List CoachesEditModels.Coach
  , coachVM : CoachesEditModels.ViewModel
  , searchVM : CoachesSearchModels.ViewModel
  }


initialCoachEditVM : CoachesEditModels.ViewModel
initialCoachEditVM = CoachesEditModels.initialViewModel


initialAppModel : AppModel
initialAppModel =
  { routeModel = initialRouteModel
  , coaches = [ ]
  , coachVM = CoachesEditModels.initialViewModel
  , searchVM = CoachesSearchModels.initialViewModel
  }