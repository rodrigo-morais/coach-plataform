module Coaches.Edit.Edit (view) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href, placeholder, cols, rows, type', checked)
import Html.Events exposing (onClick)


import String


import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)


view : Signal.Address Action -> ViewModel -> Html.Html
view address model =
  div []
      [
        flash address model,
        nav address model,
        form address model
      ]


flash : Signal.Address Action -> ViewModel -> Html
flash address model =
  let
    class' =
      case model.message.messageType of
        Blank ->
          ""

        Error ->
          "bold center p2 mb2 white bg-red rounded"

        Success ->
          "bold center p2 mb2 white bg-green rounded"


    message' =
      case model.message.messageType of
        Blank ->
          span [ ] [ ]

        _ ->
          div [ class class' ]
              [ text model.message.text ]

  in
    message'


nav : Signal.Address Action -> ViewModel -> Html.Html
nav address model =
  div [ class "clearfix mb2 white bg-black" ]
      [
        div [ class "right p1" ]
            [ saveBtn address model ]
      ]


form : Signal.Address Action -> ViewModel -> Html.Html
form address model =
  let
    name =
      if (String.isEmpty model.coach.name) then
        "New coach"
      else
        model.coach.name

  in
    div [ class "m3" ]
        [
          h1  []
              [ text name ],
          formSpot address model,
          formName address model,
          formTypes address model,
          formCapabilities address model,
          formDescription address model
        ]


formSpot : Signal.Address Action -> ViewModel -> Html.Html
formSpot address model =
  div [ class "clearfix py1" ]
      [
        div [ class "col col-3" ]
            [ text "Spots" ],
        div [ class "col col-9" ]
            [
              btnSpotDecrease address model,
              span  [ class "h2 bold" ]
                    [ text (toString model.coach.spots) ],
              btnSpotIncrease address model
            ]
      ]


btnSpotDecrease : Signal.Address Action -> ViewModel -> Html.Html
btnSpotDecrease address model =
  a [
      class "btn ml0 h1"
    ]
    [
      i [ class "fa fa-minus-circle" ]
        [ ]
    ]


btnSpotIncrease : Signal.Address Action -> ViewModel -> Html.Html
btnSpotIncrease address model =
  a [
      class "btn ml0 h1"
    ]
    [
      i [ class "fa fa-plus-circle" ]
        [ ]
    ]


formName : Signal.Address Action -> ViewModel -> Html.Html
formName address model =
  div [ class "clearfix py1" ]
      [
        div [ class "col col-3" ]
            [
              text "Name "
            ],
        div [ class "col col-9" ]
            [
              inputName address model
            ]
      ]


formTypes : Signal.Address Action -> ViewModel -> Html.Html
formTypes address model =
  div [ class "clearfix py1" ]
      [
        div [ class "col col-3" ]
            [ text "Types" ],
        div [ class "col col-9" ]
            [
              div [ class "p1" ]
                  [
                    input [
                            type' "checkbox",
                            checked model.coach.mentor
                          ]
                          [ ],
                    text "Mentor"
                  ],
              div [ class "p1" ]
                  [
                    input [
                            type' "checkbox",
                            checked model.coach.coach
                          ]
                          [ ],
                    text "Coach"
                  ]
            ]
      ]


inputName : Signal.Address Action -> ViewModel -> Html.Html
inputName address model =
  input [
          class "field-light",
          value model.coach.name,
          placeholder "New coach"
        ]
        [ ]


formCapabilities : Signal.Address Action -> ViewModel -> Html.Html
formCapabilities address model =
  div [ class "clearfix py1" ]
      [
        div [ class "col col-3" ]
            [ text "Capabilities" ],
        div [ class "col col-9" ]
            [
              inputCapabilities address model
            ]
      ]


inputCapabilities : Signal.Address Action -> ViewModel -> Html.Html
inputCapabilities address model =
  input [
          class "field-light col col-12",
          value model.coach.capabilities,
          placeholder "Fill the capabilities of coach"
        ]
        [ ]


formDescription : Signal.Address Action -> ViewModel -> Html.Html
formDescription address model =
  div [ class "clearfix py1" ]
      [
        div [ class "col col-3" ]
            [ text "Description" ],
        div [ class "col col-9" ]
            [
              inputDescription address model
            ]
      ]


inputDescription : Signal.Address Action -> ViewModel -> Html.Html
inputDescription address model =
  textarea  [
              class "field-light col col-12",
              value model.coach.description,
              placeholder "Fill the description of coach",
              cols 12,
              rows 5
            ]
            [ ]


saveBtn : Signal.Address Action -> ViewModel -> Html.Html
saveBtn address model =
  button  [
            class "btn regular",
            onClick address SaveCoach
          ]
          [
            i [ class "fa fa-floppy-o mr1" ]
              [ ],
            text "Save coach"
          ]
