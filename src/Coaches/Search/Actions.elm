module Coaches.Search.Actions (..) where


import Coaches.Search.Models exposing (..) 

import Http

type Action = 
  NoOp
  | SearchCoaches
  | SearchDone (Result Http.Error Coaches)
  | UpdateCapabilities String
  | UpdateCoach Bool
  | UpdateMentor Bool
  | SelectCoach CoachId
