module Coaches.Edit.Effects (..) where


import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Http
import Task  
import Effects  


import Coaches.Effects as CoachEffects
import Coaches.Edit.Actions exposing (..)
import Coaches.Edit.Models exposing (..)


import Configuration.Models exposing (Configuration)


saveCoach : Configuration -> Coach -> Effects.Effects Action
saveCoach configuration coach =
  let
    body = 
      coachEncoder coach
        |> Encode.encode 0
        |> Http.string
  in
    if coach.id == 0 then
      createCoach configuration body
    else
      editCoach configuration body


editCoach : Configuration -> Http.Body -> Effects.Effects Action
editCoach configuration body =
  post CoachEffects.coachDecoder configuration "POST" body
      |> Task.toResult
      |> Task.map EditDone
      |> Effects.task
    


createCoach : Configuration -> Http.Body -> Effects.Effects Action
createCoach configuration  body =
  post CoachEffects.coachDecoder configuration "POST" body
      |> Task.toResult
      |> Task.map CreateDone
      |> Effects.task


post : Decode.Decoder value -> Configuration -> String -> Http.Body -> Task.Task Http.Error value
post decoder configuration verb body =
  let
    request =
      { verb = verb
      , headers = [("Content-type", "application/json")]
      , url = saveUrl configuration
      , body = body
      }
  in
    Http.fromJson decoder (Http.send Http.defaultSettings request)


saveUrl : Configuration -> String
saveUrl configuration =
    "http://" ++ configuration.ip ++ ":" ++ configuration.ipPort ++ "/coaches"


coachEncoder : Coach -> Encode.Value
coachEncoder coach = 
  Encode.object
    [ ("id", Encode.int coach.id)
    , ("spots", Encode.int coach.spots)
    , ("name", Encode.string coach.name)
    , ("mentor", Encode.bool coach.mentor)
    , ("coach", Encode.bool coach.coach)
    , ("capabilities", Encode.string coach.capabilities)
    , ("description", Encode.string coach.description)
    ]
