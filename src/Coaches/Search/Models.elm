module Coaches.Search.Models (..) where


import Coaches.Models as CoachesModel


type alias Coach = CoachesModel.Coach
type alias Coaches = List Coach


type alias ViewModel =
  { capabilities : String 
  , coach: Bool
  , mentor: Bool
  , coaches: Coaches
  }


initialViewModel : ViewModel
initialViewModel =
  { capabilities = ""
  , coach = False
  , mentor = False
  , coaches = []
  }