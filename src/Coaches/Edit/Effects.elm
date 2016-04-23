module Coaches.Edit.Effects (..) where


import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Http
import Task  
import Effects  


import Coaches.Effects as CoachEffects
import Coaches.Edit.Actions exposing (..)
import Coaches.Edit.Models exposing (..)


saveCoach : Coach -> Effects.Effects Action
saveCoach coach =
  let
    body = 
      coachEncoder coach
        |> Encode.encode 0
        |> Http.string
  in
    if coach.id == 0 then
      createCoach body
    else
      editCoach body


editCoach : Http.Body -> Effects.Effects Action
editCoach body =
  post CoachEffects.coachDecoder "POST" body
      |> Task.toResult
      |> Task.map EditDone
      |> Effects.task
    


createCoach : Http.Body -> Effects.Effects Action
createCoach body =
  post CoachEffects.coachDecoder "POST" body
      |> Task.toResult
      |> Task.map CreateDone
      |> Effects.task


post : Decode.Decoder value -> String -> Http.Body -> Task.Task Http.Error value
post decoder verb body =
  let
    request =
      { verb = verb
      , headers = [("Content-type", "application/json")]
      , url = saveUrl
      , body = body
      }
  in
    Http.fromJson decoder (Http.send Http.defaultSettings request)


saveUrl : String
saveUrl =
    "http://localhost:4000/coaches"


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
