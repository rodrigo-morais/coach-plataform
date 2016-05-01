module Coaches.Search.View (..) where

import Coaches.View as CoachesView
import Coaches.Search.Models exposing (..)
import Coaches.Search.Actions exposing (..)


import Configuration.Models exposing (Configuration)


import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


view : Signal.Address Action -> Configuration -> ViewModel -> Html.Html
view address configuration model = 
  div
    [ class "clearfix" ]
    [ div
        [ class "col-8 mx-auto mt2" ]
        [ searchFields address configuration model
        , coaches address model.coaches
        ]
    ]
  

searchFields : Signal.Address Action -> Configuration -> ViewModel -> Html.Html
searchFields address configuration model =
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
            , style [("padding-right", "0")] 
            ]
            [ inputType address model.coach "Coach" UpdateCoach
            , inputType address model.mentor "Mentor" UpdateMentor
            , searchButton address configuration
            ]
        ]
    ]

inputCapabilities : Signal.Address Action -> String -> Html.Html
inputCapabilities address capabilities =
  input 
    [ id "capabilities"
    , class "input col-12 col py1"
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


searchButton : Signal.Address Action -> Configuration -> Html.Html
searchButton address configuration =
  div
    [ class "col col-4"]
    [ button
        [ id "searchButton"
        , onClick address (SearchCoaches configuration)
        , class "btn rounded white bg-black right"
        ] 
        [ text "Search"]
    ]


coaches : Signal.Address Action -> Coaches -> Html.Html
coaches address coaches =
  let
    urlEdit coachId =
      "#/coaches/" ++ toString(coachId) ++ "/edit"

    coachRow coach =
      div
        [ class "clearfix border-box border mt2"]
        [ div
            [ class "col col-2"]
            [ img [ src coachImageUrl ] [] ]
        , div
            [ class "col col-10"]
            [ div
                [class "p2 bold col col-12"]
                [
                  a [
                      href (urlEdit coach.id)
                    , class "text-decoration-none"
                    , style [("color", "#000000")]
                    , onClick address (SelectCoach coach.id)
                  ]
                  [
                    text coach.name
                  ]
                ]
            , div
                [class "p2 col col-12"]
                [ div [ class "col col-6" ]
                      [ text ((toString coach.spots) ++ " spots") ]
                , div [ class "col col-3" ]
                      [ editButton address coach.id ]
                , div [ class "col col-3" ]
                      [ viewButton address coach.id ]
                ]
            , div
                [class "px1 col col-12"]
                [ showType coach.coach "Coach" coach.id
                , showType coach.mentor "Mentor" coach.id
                ]
            , div
                [class "p2 col col-12"]
                [text coach.capabilities]
            ]
        ]
    coachList = List.map coachRow coaches 
  in
    div
      [ class "mt1"]
      coachList


showType : Bool -> String -> Int -> Html.Html
showType model typeName coachId =
  let
    inputId = typeName ++ (toString coachId)
  in
    div
      [ class "col col-2"]
      [ input 
          [ id inputId
          , type' "checkbox"
          , checked model
          , disabled True
          ]
          []
      , label [for inputId] [text typeName]
      ]

coachImageUrl = 
  "http://img12.deviantart.net/5921/i/2013/082/6/1/south_park_character_png_by_lalbiel-d5yzsp2.png"


editButton : Signal.Address Action -> CoachId -> Html.Html
editButton address coachId =
  a [ href ("#/coaches/" ++ toString(coachId) ++ "/edit")
    , class "col col-11 mr1" ]
    [
      button  [ id ("editButton-" ++ toString(coachId))
              , class "col col-12"
              , onClick address (SelectCoach coachId)
              ]
              [ text "Edit" ]
    ]


viewButton : Signal.Address Action -> CoachId -> Html.Html
viewButton address coachId =
  a [ href ("#/coaches/" ++ toString(coachId) ++ "/edit")
    , class "col col-11 ml1" ]
    [
      button  [ id ("viewButton-" ++ toString(coachId))
              , class "col col-12"
              , onClick address (ViewCoach coachId)
              ]
              [ text "View" ]
    ]