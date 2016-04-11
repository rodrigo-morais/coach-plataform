module Main (..) where


import StartApp
import Effects exposing (Effects, Never)
import Task

import Router.Routing exposing (..)

--import Coaches.Search.Models exposing (..)
--import Coaches.Search.Actions exposing (..)
--import Coaches.Search.Update exposing (..)
--import Coaches.Search.View as SearchView

--import Coaches.Edit.Edit as EditView
--import Coaches.Edit.Models exposing (..)
--import Coaches.Edit.Actions exposing (..)
--import Coaches.Edit.Update exposing (..)

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

--init : (SearchModel, Effects Action)
--init =
--  (initialSearchModel, Effects.none)

--init : (ViewModel, Effects Action)
--init =
--  (initialViewModel, Effects.none)

--view address model = 
--  SearchView.view address model
  
--view address model = 
--  EditView.view address model

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
