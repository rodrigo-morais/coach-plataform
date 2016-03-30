module Coaches.Edit.Update (..) where 


import Effects exposing (Effects)


import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)


update : Action -> Model -> (Model, Effects Action)
update action model = 
    case action of 
        NoOp -> (model, Effects.none)
