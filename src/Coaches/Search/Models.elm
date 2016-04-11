module Coaches.Search.Models (..) where


import Coaches.Models as CoachesModel


type alias Coach = CoachesModel.Coach
type alias Coaches = List Coach


type alias ViewModel =
  { capabilities : String 
  , coaches: Coaches
  }


initialViewModel : ViewModel
initialViewModel =
  { capabilities = ""
  , coaches = []
  }