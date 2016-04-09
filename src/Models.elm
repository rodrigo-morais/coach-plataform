module Models (..) where


import Router.Models exposing (..)
import Coaches.Edit.Models as CoachesEditModels

type alias AppModel =
  { routeModel : RouteModel
  , coaches : List CoachesEditModels.Coach
  , coachVM : CoachesEditModels.ViewModel
  }


initialCoachEditVM : CoachesEditModels.ViewModel
initialCoachEditVM = CoachesEditModels.initialViewModel


initialAppModel : AppModel
initialAppModel =
  { routeModel = initialRouteModel
  , coaches = [ ]
  , coachVM = CoachesEditModels.initialViewModel
  }