module Coaches.Search.Models (..) where


import Coaches.Models as CoachesModel


type alias Coach = CoachesModel.Coach
type alias Coaches = List Coach


type alias SearchModel =
  { capabilities : String 
  , coaches: Coaches
  }


initialSearchModel : SearchModel
initialSearchModel =
  { capabilities = ""
  , coaches = []
  }