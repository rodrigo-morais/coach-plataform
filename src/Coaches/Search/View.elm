module Coaches.Search.View (..) where

import Coaches.View as CoachesView
import Coaches.Search.Models exposing (..)
import Coaches.Search.Actions exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Signal.Address Action -> ViewModel -> Html.Html
view address model = 
  div 
    []
    [ searchFields address model 
    , coaches address model.coaches
    ]


searchFields : Signal.Address Action -> ViewModel -> Html.Html
searchFields address model =
  div
    []
    [ input 
        [ value model.capabilities
        , placeholder "capabilities"
        , CoachesView.onTextChange address UpdateCapabilities
        ]
        []
    , searchButton address
    ]


searchButton : Signal.Address Action -> Html.Html
searchButton address =
  button [onClick address SearchCoaches] [text "Search"]


coaches : Signal.Address Action -> Coaches -> Html.Html
coaches address coaches =
  let
    coachRow coach =
      tr
        []
        [ td [] [text coach.name]
        , td [] [text (toString coach.spots)]
        , td [] [text (toString coach.mentor)]
        , td [] [text (toString coach.coach)]
        , td [] [text coach.capabilities]
        , td [] [text coach.description]
        ]
    coachList = List.map coachRow coaches 
  in
    table
      []
      coachList

