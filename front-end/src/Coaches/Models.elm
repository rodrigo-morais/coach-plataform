module Coaches.Models (..) where


type alias CoachId = Int


type alias Coach =
  { id: CoachId
  , spots: Int
  , name: String
  , mentor: Bool
  , coach: Bool
  , capabilities: String
  , description: String
  }


initialCoach : Coach
initialCoach =
  { id = 0
  , spots = 0
  , name = ""
  , mentor = False
  , coach = False
  , capabilities = ""
  , description = ""
  }

