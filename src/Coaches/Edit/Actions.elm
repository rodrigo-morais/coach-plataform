module Coaches.Edit.Actions (..) where


import Coaches.Edit.Models exposing (..)

import Http


type Action 
  = NoOp
  | Save
  | SaveDone (Result Http.Error Coach)
  | UpdateSpotsIncrease
  | UpdateSpotsDecrease
  | UpdateName String
  | UpdateMentor Bool
  | UpdateCoach Bool
  | UpdateCapabilities String
  | UpdateDescription String
