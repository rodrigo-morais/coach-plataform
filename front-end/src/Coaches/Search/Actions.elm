module Coaches.Search.Actions (..) where


import Coaches.Search.Models exposing (..) 


import Configuration.Models exposing (Configuration)


import Http

type Action = 
  NoOp
  | SearchCoaches Configuration
  | SearchDone (Result Http.Error Coaches)
  | UpdateCapabilities String
  | UpdateCoach Bool
  | UpdateMentor Bool
  | SelectCoach CoachId
  | ViewCoach CoachId
