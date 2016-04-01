module Coaches.Edit.Update (..) where


import Effects exposing (Effects)


import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)


update : Action -> ViewModel -> (ViewModel, Effects Action)
update action model =
    case action of
        NoOp -> (model, Effects.none)

        SaveCoach ->
          let
            updateMessage message =
              { message | text = "Error when saving coach.", messageType = Error }


            updatedViewModel =
              { coach = model.coach, message = (updateMessage model.message) }


          in
            (updatedViewModel, Effects.none)
