module Coaches.Edit.Effects (..) where


import Json.Decode as Decode exposing ((:=))
import Json.Encode as Encode
import Http
import Task  
import Effects  


import Coaches.Effects as CoachEffects
import Coaches.Edit.Actions exposing (..)
import Coaches.Edit.Models exposing (..)


saveCoaches : Coach -> Effects.Effects Action
saveCoaches coach =
  let body = 
    coachEncoder coach
      |> Encode.encode 0
      |> Http.string
  in
    post CoachEffects.coachDecoder saveUrl body
      |> Task.toResult
      |> Task.map SaveDone
      |> Effects.task


post : Decode.Decoder value -> String -> Http.Body -> Task.Task Http.Error value
post decoder url body =
  let request =
    { verb = "POST"
    , headers = [("Content-type", "application/json")]
    , url = url
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
