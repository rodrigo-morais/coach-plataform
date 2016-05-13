module Coaches.Edit.Actions (..) where


import Coaches.Edit.Models exposing (..)


import Configuration.Models exposing (Configuration)


import Http


type Action 
  = NoOp
  | Save Configuration
  | CreateDone (Result Http.Error Coach)
  | EditDone (Result Http.Error Coach)
  | IncreaseSpots
  | DecreaseSpots
  | SetName String
  | SetMentor Bool
  | SetCoach Bool
  | SetCapabilities String
  | SetDescription String
