module Coaches.Edit.View (view) where


import Html exposing (..)
import Html.Attributes exposing (class, value, href, placeholder, cols, rows, type', checked, readonly, disabled)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import String


import Coaches.View as CoachesView
import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)


import Configuration.Models exposing (Configuration)


view : Signal.Address Action -> Configuration -> ViewModel -> Html.Html
view address configuration model =
  div 
    []
    [ flash address model.message
    , form address configuration model.coach model.editable
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


form : Signal.Address Action -> Configuration -> Coach -> Bool -> Html.Html
form address configuration coach editable =
  let name =
    if (String.isEmpty coach.name) then
      "New coach"
    else
      coach.name
  in
    div 
      [ class "m3" ]
      [ h1  [] [ text name ]
      , formSpot address coach editable
      , formName address coach editable
      , formTypes address coach editable
      , formCapabilities address coach editable
      , formDescription address coach editable
      , formSaveButton address configuration coach editable
      ]


formSpot : Signal.Address Action -> Coach -> Bool -> Html.Html
formSpot address coach editable =
  div 
    [ class "clearfix py1" ]
    [ div 
        [ class "col col-3" ]
        [ text "Spots" ]
    , div 
        [ class "col col-9" ]
        [ btnSpotDecrease address coach editable
        , span
            [ class "h2 bold" ]
            [ text (toString coach.spots) ]
        , btnSpotIncrease address coach editable
        ]
    ]


btnSpotDecrease : Signal.Address Action -> Coach -> Bool -> Html.Html
btnSpotDecrease address coach editable =
  let
    action =
      if editable then
        DecreaseSpots
      else
        NoOp

  in
    a 
      [ class "btn ml0 h1"
      , onClick address action
      ]
      [ i [ class "fa fa-minus-circle" ] [] ]


btnSpotIncrease : Signal.Address Action -> Coach -> Bool -> Html.Html
btnSpotIncrease address coach editable =
  let
    action =
      if editable then
        IncreaseSpots
      else
        NoOp

  in
    a 
      [ class "btn ml0 h1"
      , onClick address action
      ]
      [ i [ class "fa fa-plus-circle" ] [] ]


formName : Signal.Address Action -> Coach -> Bool -> Html.Html
formName address coach editable =
  div [ class "clearfix py1" ]
      [ div [ class "col col-3" ]
            [ text "Name "]
      , div [ class "col col-9" ]
            [ inputName address coach editable ]
      ]


formTypes : Signal.Address Action -> Coach -> Bool -> Html.Html
formTypes address coach editable =
  div [ class "clearfix py1" ]
      [ div [ class "col col-3" ]
            [ text "Types" ]
      , div [ class "col col-9" ]
            [ formType address coach.mentor editable "Mentor" SetMentor
            , formType address coach.coach editable "Coach" SetCoach
            ]
      ]


formType : Signal.Address Action -> Bool -> Bool -> String -> (Bool -> Action) -> Html.Html
formType address model editable typeName action =
  let
    onChangeValue value =
      Signal.message address (action value)

    isDisabled =
      not editable

  in
    div 
      [ class "p1" ]
      [ input 
          [ type' "checkbox"
          , checked model
          , on "change" targetChecked onChangeValue
          , disabled isDisabled
          ]
          [ ]
      , text typeName
      ]


inputName : Signal.Address Action -> Coach -> Bool -> Html.Html
inputName address coach editable =
  let
    isReadOnly =
      not editable

  in
    input [ class "field-light"
          , value coach.name
          , placeholder "New coach"
          , CoachesView.onTextChange address SetName
          , readonly isReadOnly
          ]
          [ ]


formCapabilities : Signal.Address Action -> Coach -> Bool -> Html.Html
formCapabilities address coach editable =
  div [ class "clearfix py1" ]
      [ div
        [ class "col col-3" ]
        [ text "Capabilities" ]
      , div
        [ class "col col-9" ]
        [ inputCapabilities address coach editable ]
      ]


inputCapabilities : Signal.Address Action -> Coach -> Bool -> Html.Html
inputCapabilities address coach editable =
  let
    isReadOnly =
      not editable

  in
    input [ class "field-light col col-12"
          , value coach.capabilities
          , placeholder "Fill the capabilities of coach"
          , CoachesView.onTextChange address SetCapabilities
          , readonly isReadOnly
          ]
          [ ]


formDescription : Signal.Address Action -> Coach -> Bool -> Html.Html
formDescription address coach editable =
  div [ class "clearfix py1" ]
      [ div
          [ class "col col-3" ]
          [ text "Description" ]
      , div 
          [ class "col col-9" ]
          [ inputDescription address coach editable ]
      ]


inputDescription : Signal.Address Action -> Coach -> Bool -> Html.Html
inputDescription address coach editable =
  let
    isReadOnly =
      not editable

  in
    textarea
      [ class "field-light col col-12"
      , value coach.description
      , placeholder "Fill the description of coach"
      , cols 12
      , rows 5
      , CoachesView.onTextChange address SetDescription
      , readonly isReadOnly
      ]
      [ ]


formSaveButton : Signal.Address Action -> Configuration -> Coach -> Bool -> Html.Html
formSaveButton address configuration coach editable =
  let
    action =
      if editable then
        (Save configuration)
      else
        NoOp

    isDisabled =
      not editable

    visible =
      if editable then
        "display-block"
      else
        "display-none"

    class' =
      "btn regular border mt2 col col-12 rounded " ++ visible

  in
    button
      [ class class'
      , onClick address action
      , disabled isDisabled
      ]
      [ i [ class "fa fa-floppy-o mr1" ] []
      , text "Save Coach"
      ]

