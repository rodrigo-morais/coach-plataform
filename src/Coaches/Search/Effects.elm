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


doSearch : ViewModel -> Effects.Effects Action
doSearch model =
  let 
    url = searchUrl model
  in
    Http.get (Decode.list CoachEffects.coachDecoder) url
      |> Task.toResult
      |> Task.map SearchDone
      |> Effects.task


searchUrl : ViewModel -> String
searchUrl model =
  "http://localhost:4000/coaches?" 
    ++ capabilitiesQuery model
    ++ typeQueries model


capabilitiesQuery : ViewModel -> String
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
    

typeQueries : ViewModel -> String
typeQueries model =
  let
    -- Probably there is a better way to do this
    coach =
      if model.coach == False then
        if model.mentor == False then "" else "&coach=false"
      else
        "&coach=true"
    mentor =
      if model.mentor == False then
        if model.coach == False then "" else "&mentor=false"
      else
        "&mentor=true"
  in
    coach ++ mentor


  
