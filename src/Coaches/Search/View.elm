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
    [ class "clearfix" ]
    [ div
        [ class "col-8 mx-auto mt2" ]
        [ div
            []
            [searchFields address model]
        , coaches address model.coaches
        ]
    ]
  

searchFields : Signal.Address Action -> ViewModel -> Html.Html
searchFields address model =
  div
    [ class "clearfix"]
    [ div
        [ class "col col-9"]
        [ input 
          [ class "input col-12 col py1"
          , value model.capabilities
          , placeholder "Search by capabilities"
          , CoachesView.onTextChange address UpdateCapabilities
          ]
          []
        ]
    , div
        [ class "col col-3 px2" ]
        [ searchButton address ]
    ]


searchButton : Signal.Address Action -> Html.Html
searchButton address =
  button 
    [ onClick address SearchCoaches
    , class "btn rounded white bg-black"
    ] 
    [ text "Search"]


coaches : Signal.Address Action -> Coaches -> Html.Html
coaches address coaches =
  let
    coachRow coach =
      div
        [class "overflow-hidden border rounded mt2"]
        [ div
            [class "p2 bold white bg-black"]
            [text coach.name]
        , div
            [class "p2"]
            [text coach.capabilities]
        , div
            [class "p2"]
            [text coach.description]
        ]
    coachList = List.map coachRow coaches 
  in
    div
      [ class "mt1"]
      coachList

