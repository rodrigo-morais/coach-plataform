module Coaches.Search.Models (..) where


import Coaches.Models as CoachesModel


type alias Coach = CoachesModel.Coach
type alias CoachId = CoachesModel.CoachId
type alias Coaches = List Coach


type alias ViewModel =
  { capabilities : String 
  , coach : Bool
  , mentor : Bool
  , coaches : Coaches
  , selectedCoach : {
      coach : Coach
    , editable : Bool
    }
  }


initialViewModel : ViewModel
initialViewModel =
  { capabilities = ""
  , coach = False
  , mentor = False
  , coaches = []
  , selectedCoach = {
      coach = CoachesModel.initialCoach
    , editable = True
    }
  }