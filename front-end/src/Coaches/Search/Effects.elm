module Coaches.Search.Effects (..) where


import Coaches.Effects as CoachEffects
import Coaches.Search.Actions exposing (..)
import Coaches.Search.Models exposing (..)


import Configuration.Models exposing (Configuration)

import Regex
import String
import Effects
import Task
import Http
import Json.Decode as Decode


doSearch : ViewModel -> Configuration -> Effects.Effects Action
doSearch model configuration =
  let 
    url = searchUrl model configuration
  in
    Http.get (Decode.list CoachEffects.coachDecoder) url
      |> Task.toResult
      |> Task.map SearchDone
      |> Effects.task


searchUrl : ViewModel -> Configuration -> String
searchUrl model configuration =
  let
    url =
      case configuration.ip of
        "/server" -> configuration.ip ++ "/coaches?"
        _ -> "http://" ++ configuration.ip ++ ":" ++ configuration.ipPort ++ "/coaches?"

  in
    url
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
    coach =
      if model.coach == True then "&coach=true" else ""
        
    mentor =
      if model.mentor == True then "&mentor=true" else ""
  in
    coach ++ mentor


  
