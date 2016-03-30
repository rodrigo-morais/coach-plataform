module Main (..) where 


import StartApp 
import Effects exposing (Effects, Never)
import Task  

import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)
import Coaches.Edit.Update exposing (..)
import Coaches.Edit.Edit exposing (..)


init : (Model, Effects Action)
init =
    (initialModel, Effects.none)


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


main =
    app.html


port runner : Signal (Task.Task Never ())
port runner =
  app.tasks