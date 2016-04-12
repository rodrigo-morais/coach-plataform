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
        [ searchFields address model
        , coaches address model.coaches
        ]
    ]
  

searchFields : Signal.Address Action -> ViewModel -> Html.Html
searchFields address model =
  div
    []
    [ div
        [ class "clearfix"]
        [ div
            [ class "col col-7"]
            [ inputCapabilities address model.capabilities
            ]
        , div
            [ class "col col-5 px2"
            -- Don't know why, but pl2 does not work
            , style [("padding-right", "0")] 
            ]
            [ inputType address model.coach "Coach" UpdateCoach
            , inputType address model.mentor "Mentor" UpdateMentor
            , searchButton address 
            ]
        ]
    ]

inputCapabilities : Signal.Address Action -> String -> Html.Html
inputCapabilities address capabilities =
  input 
    [ class "input col-12 col py1 border rounded"
    , value capabilities
    , placeholder "Search by capabilities"
    , CoachesView.onTextChange address UpdateCapabilities
    ]
    []

inputType : Signal.Address Action -> Bool -> String -> (Bool -> Action) -> Html.Html
inputType address model typeName action =
  let onChangeValue value =
    Signal.message address (action value)
  in
    div 
      [ class "col col-4 py1" ]
      [ input 
          [ id typeName
          , type' "checkbox"
          , checked model
          , on "change" targetChecked onChangeValue
          ]
          []
      , label [for typeName] [text typeName]
      ]


searchButton : Signal.Address Action -> Html.Html
searchButton address =
  div
    [ class "col col-4"]
    [ button
        [ onClick address SearchCoaches
        , class "btn rounded white bg-black right"
        ] 
        [ text "Search"]
    ]


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

