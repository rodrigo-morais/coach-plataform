module Coaches.Search.Effects (..) where


import Coaches.Effects as CoachEffects
import Coaches.Search.Actions exposing (..)
import Coaches.Search.Models exposing (..)

import Regex
import String
import Effects
import Task
import Http
import Json.Decode as Decode


doSearch : SearchModel -> Effects.Effects Action
doSearch model =
  let 
    url = searchUrl model
  in
    Http.get (Decode.list CoachEffects.coachDecoder) url
      |> Task.toResult
      |> Task.map SearchDone
      |> Effects.task


searchUrl : SearchModel -> String
searchUrl model =
  "http://localhost:4000/coaches?" 
    ++ capabilitiesQuery model


capabilitiesQuery : SearchModel -> String
capabilitiesQuery model =
  let
    pattern = (Regex.regex ",( *)") 
    queryMultiple = 
      Regex.replace
        Regex.All 
        pattern
        (\_ -> "|")
  in
    "capabilities_like=" ++ (queryMultiple model.capabilities)

