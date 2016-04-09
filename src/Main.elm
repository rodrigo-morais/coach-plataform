module Main (..) where


import StartApp
import Effects exposing (Effects, Never)
import Task

import Router.Routing exposing (..)


import Actions exposing (..)
import Models exposing (..)
import View exposing (..)
import Update exposing (..)


init : ( AppModel, Effects Actions.Action )
init =
  let
    fxs = [ Effects.map CoachesEditAction Effects.none ]
    fx = Effects.batch fxs

  in
    (initialAppModel, fx)


routerSignal : Signal Actions.Action
routerSignal =
  Signal.map RoutingAction Router.Routing.signal


app =
  StartApp.start
    { init = init
    , update = Update.update
    , view = view
    , inputs = [routerSignal]
    }


main =
  app.html


port runner : Signal (Task.Task Never ())
port runner =
  app.tasks


port routeRunTask : Task.Task () ()
port routeRunTask =
  Router.Routing.run
