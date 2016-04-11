module Coaches.Effects (..) where 


import Coaches.Models exposing (..)

import Effects
import Json.Decode as Decode exposing ((:=))


coachDecoder : Decode.Decoder Coach
coachDecoder =
  Decode.object7
    Coach
    ("id" := Decode.int)
    ("spots" := Decode.int)
    ("name" := Decode.string)
    ("mentor" := Decode.bool)
    ("coach" := Decode.bool)
    ("capabilities" := Decode.string)
    ("description" := Decode.string)

