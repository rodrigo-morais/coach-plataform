module Coaches.Edit.Update (..) where


import Effects exposing (Effects)


import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)
import Coaches.Edit.Effects exposing (..)


update : Action -> ViewModel -> (ViewModel, Effects Action)
update action model = 
  let 
    coach =
      model.coach

    updateCoach newCoach = 
      ({ model | coach = newCoach }, Effects.none)

  in
    case action of 
      NoOp -> (model, Effects.none)

      Save configuration ->
        (model, saveCoach configuration coach)

      CreateDone result ->
        case result of
          Ok coach ->
            let
              updatedViewModel =
                { coach = model.coach
                , message = successCreateMessage
                , editable = False
                }
            in
              (updatedViewModel, Effects.none)

          Err error ->
            ({model | message = errorMessage}, Effects.none)

      EditDone result ->
        case result of
          Ok coach ->
            let
              updatedViewModel =
                { coach = model.coach
                , message = successEditMessage
                , editable = False
                }
            in
              (updatedViewModel, Effects.none)

          Err error ->
            ({model | message = errorMessage}, Effects.none)

      IncreaseSpots ->
        updateCoach({coach | spots = coach.spots + 1})

      DecreaseSpots ->
        let
          spots =
            if coach.spots == 0 then
              0
            else
              coach.spots - 1

        in
          updateCoach({ coach | spots = spots })

      SetName newName -> 
        updateCoach({coach | name = newName})

      SetMentor value -> 
        updateCoach({coach | mentor = value})

      SetCoach value -> 
        updateCoach({coach | coach = value})

      SetCapabilities value -> 
        updateCoach({coach | capabilities = value})

      SetDescription value -> 
        updateCoach({coach | description = value})


errorMessage : Message
errorMessage =
  { text = "Error when saving coach."
  , messageType = Error 
  }

successCreateMessage : Message
successCreateMessage =
  { text = "New coach created with success."
  , messageType = Success
  }

successEditMessage : Message
successEditMessage =
  { text = "Coach edited with success."
  , messageType = Success
  }
