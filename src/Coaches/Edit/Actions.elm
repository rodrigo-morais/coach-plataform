module Coaches.Edit.Actions (..) where


import Coaches.Edit.Models exposing (..)

import Http


type Action 
  = NoOp
  | Save
  | SaveDone (Result Http.Error Coach)
  | IncreaseSpots
  | DecreaseSpots
  | SetName String
  | SetMentor Bool
  | SetCoach Bool
  | SetCapabilities String
  | SetDescription String
