module Coaches.Edit.Update (..) where


import Effects exposing (Effects)


import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)
import Coaches.Edit.Effects exposing (..)


update : Action -> ViewModel -> (ViewModel, Effects Action)
update action model = 
  let 
    coach = Debug.log "coach" model.coach

    updateCoach newCoach = 
      ({model | coach = newCoach}, Effects.none) 
  in
    case action of 
      NoOp -> (model, Effects.none)

      Save -> (model, saveCoaches coach)

      SaveDone result -> 
        case result of
          Ok coach ->
            let
              updatedViewModel =
                { coach = model.coach
                , message = successMessage 
                }
            in
              (updatedViewModel, Effects.none)

          Err error ->
            ({model | message = errorMessage}, Effects.none)

      UpdateSpotsIncrease ->
        updateCoach({coach | spots = coach.spots + 1})

      UpdateSpotsDecrease ->
        updateCoach({coach | spots = coach.spots - 1})

      UpdateName newName -> 
        updateCoach({coach | name = newName})

      UpdateMentor value -> 
        updateCoach({coach | mentor = value})

      UpdateCoach value -> 
        updateCoach({coach | coach = value})

      UpdateCapabilities value -> 
        updateCoach({coach | capabilities = value})

      UpdateDescription value -> 
        updateCoach({coach | description = value})


errorMessage : Message
errorMessage =
  { text = "Error when saving coach."
  , messageType = Error 
  }

successMessage : Message
successMessage =
  { text = "New coach created."
  , messageType = Success
  }
