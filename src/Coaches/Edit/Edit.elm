module Coaches.Edit.Edit (view) where


import Html exposing (..)
import Html.Attributes exposing (class, value, href, placeholder, cols, rows, type', checked, readonly, disabled)
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
    , form address model.coach model.editable
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


form : Signal.Address Action -> Coach -> Bool -> Html.Html
form address coach editable =
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
        UpdateSpotsDecrease
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
        UpdateSpotsIncrease
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
            [ formType address coach.mentor editable "Mentor" UpdateMentor
            , formType address coach.coach editable "Coach" UpdateCoach
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
          , CoachesView.onTextChange address UpdateName
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
          , CoachesView.onTextChange address UpdateCapabilities
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
      , CoachesView.onTextChange address UpdateDescription
      , readonly isReadOnly
      ]
      [ ]


saveBtn : Signal.Address Action -> Coach -> Bool -> Html.Html
saveBtn address coach editable =
  button
    [ class "btn regular"
    , onClick address Save
    ]
    [ i [ class "fa fa-floppy-o mr1" ] []
    , text "Save coach"
    ]

