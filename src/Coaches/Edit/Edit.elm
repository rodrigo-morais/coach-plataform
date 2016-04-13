module Coaches.Edit.Edit (view) where


import Html exposing (..)
import Html.Attributes exposing (class, value, href, placeholder, cols, rows, type', checked)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import String


import Coaches.View as CoachesView
import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)


view : Signal.Address Action -> ViewModel -> Html.Html
view address model =
  div 
    []
    [ flash address model.message
    , form address model.coach
    ]


flash : Signal.Address Action -> Message -> Html
flash address message =
  let 
    class' =
      case message.messageType of
        Blank ->
          ""

        Error ->
          "bold center p2 mb2 white bg-red rounded"

        Success ->
          "bold center p2 mb2 white bg-green rounded"

    message' =
      case message.messageType of
        Blank ->
          span [] []

        _ ->
          div 
            [ class class' ]
            [ text message.text ]
  in
    message'


form : Signal.Address Action -> Coach -> Html.Html
form address coach =
  let name =
    if (String.isEmpty coach.name) then
      "New coach"
    else
      coach.name
  in
    div 
      [ class "m3" ]
      [ h1  [] [ text name ]
      , formSpot address coach
      , formName address coach
      , formTypes address coach
      , formCapabilities address coach
      , formDescription address coach
      ]


formSpot : Signal.Address Action -> Coach -> Html.Html
formSpot address coach =
  div 
    [ class "clearfix py1" ]
    [ div 
        [ class "col col-3" ]
        [ text "Spots" ]
    , div 
        [ class "col col-9" ]
        [ btnSpotDecrease address coach
        , span
            [ class "h2 bold" ]
            [ text (toString coach.spots) ]
        , btnSpotIncrease address coach
        ]
    ]


btnSpotDecrease : Signal.Address Action -> Coach -> Html.Html
btnSpotDecrease address coach =
  a 
    [ class "btn ml0 h1"
    , onClick address UpdateSpotsDecrease
    ]
    [ i [ class "fa fa-minus-circle" ] [] ]


btnSpotIncrease : Signal.Address Action -> Coach -> Html.Html
btnSpotIncrease address coach =
  a [ class "btn ml0 h1"
    , onClick address UpdateSpotsIncrease
    ]
    [ i [ class "fa fa-plus-circle" ] [] ]


formName : Signal.Address Action -> Coach -> Html.Html
formName address coach =
  div [ class "clearfix py1" ]
      [ div [ class "col col-3" ]
            [ text "Name "]
      , div [ class "col col-9" ]
            [ inputName address coach ]
      ]


formTypes : Signal.Address Action -> Coach -> Html.Html
formTypes address coach =
  div [ class "clearfix py1" ]
      [ div [ class "col col-3" ]
            [ text "Types" ]
      , div [ class "col col-9" ]
            [ formType address coach.mentor "Mentor" UpdateMentor
            , formType address coach.coach "Coach" UpdateCoach
            ]
      ]


formType : Signal.Address Action -> Bool -> String -> (Bool -> Action) -> Html.Html
formType address model typeName action =
  let onChangeValue value =
    Signal.message address (action value)
  in
    div 
      [ class "p1" ]
      [ input 
          [ type' "checkbox"
          , checked model
          , on "change" targetChecked onChangeValue
          ]
          []
      , text typeName
      ]


inputName : Signal.Address Action -> Coach -> Html.Html
inputName address coach =
  input [ class "field-light"
        , value coach.name
        , placeholder "New coach"
        , CoachesView.onTextChange address UpdateName
        ]
        []


formCapabilities : Signal.Address Action -> Coach -> Html.Html
formCapabilities address coach =
  div [ class "clearfix py1" ]
      [ div
        [ class "col col-3" ]
        [ text "Capabilities" ]
      , div
        [ class "col col-9" ]
        [ inputCapabilities address coach ]
      ]


inputCapabilities : Signal.Address Action -> Coach -> Html.Html
inputCapabilities address coach =
  input [ class "field-light col col-12"
        , value coach.capabilities
        , placeholder "Fill the capabilities of coach"
        , CoachesView.onTextChange address UpdateCapabilities
        ]
        []


formDescription : Signal.Address Action -> Coach -> Html.Html
formDescription address coach =
  div [ class "clearfix py1" ]
      [ div
          [ class "col col-3" ]
          [ text "Description" ]
      , div 
          [ class "col col-9" ]
          [ inputDescription address coach ]
      ]


inputDescription : Signal.Address Action -> Coach -> Html.Html
inputDescription address coach =
  textarea
    [ class "field-light col col-12"
    , value coach.description
    , placeholder "Fill the description of coach"
    , cols 12
    , rows 5
    , CoachesView.onTextChange address UpdateDescription
    ]
    []


saveBtn : Signal.Address Action -> Coach -> Html.Html
saveBtn address coach =
  button
    [ class "btn regular"
    , onClick address Save
    ]
    [ i [ class "fa fa-floppy-o mr1" ] []
    , text "Save coach"
    ]

