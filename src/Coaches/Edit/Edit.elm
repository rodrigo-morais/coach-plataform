module Coaches.Edit.Edit (..) where

import Html exposing (..)
import Html.Attributes exposing (class, value, href, placeholder, cols, rows, type', checked)


import String


import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)


view : Signal.Address Action -> Model -> Html.Html
view address model =
  div []
      [
        nav address model,
        form address model
      ]


nav : Signal.Address Action -> Model -> Html.Html
nav address model =
  div [ class "clearfix mb2 white bg-black" ]
      [
        div [ class "right p1" ]
            [ saveBtn address model ]
      ]


form : Signal.Address Action -> Model -> Html.Html
form address model =
  let
    name =
      if (String.isEmpty model.name) then
        "New coach"
      else
        model.name

  in
    div [ class "m3" ]
        [
          h1  []
              [ text name ],
          formSpots address model,
          formName address model,
          formTypes address model,
          formCapabilities address model,
          formDescription address model
        ]


formSpots : Signal.Address Action -> Model -> Html.Html
formSpots address model =
  div [ class "clearfix py1" ]
      [
        div [ class "col col-3" ]
            [ text "Spots" ],
        div [ class "col col-9" ]
            [
              btnSpotDecrease address model,
              span  [ class "h2 bold" ]
                    [ text (toString model.spots) ],
              btnSpotIncrease address model
            ]
      ]


btnSpotDecrease : Signal.Address Action -> Model -> Html.Html
btnSpotDecrease address model =
  a [
      class "btn ml0 h1"
    ]
    [
      i [ class "fa fa-minus-circle" ]
        [ ]
    ]


btnSpotIncrease : Signal.Address Action -> Model -> Html.Html
btnSpotIncrease address model =
  a [
      class "btn ml0 h1"
    ]
    [
      i [ class "fa fa-plus-circle" ]
        [ ]
    ]


formName : Signal.Address Action -> Model -> Html.Html
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


formTypes : Signal.Address Action -> Model -> Html.Html
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
                            checked model.mentor
                          ]
                          [ ],
                    text "Mentor"
                  ],
              div [ class "p1" ]
                  [
                    input [
                            type' "checkbox",
                            checked model.coach
                          ]
                          [ ],
                    text "Coach"
                  ]
            ]
      ]


inputName : Signal.Address Action -> Model -> Html.Html
inputName address model =
  input [
          class "field-light",
          value model.name,
          placeholder "New coach"
        ]
        [ ]


formCapabilities : Signal.Address Action -> Model -> Html.Html
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


inputCapabilities : Signal.Address Action -> Model -> Html.Html
inputCapabilities address model =
  input [
          class "field-light col col-12",
          value model.capabilities,
          placeholder "Fill the capabilities of coach"
        ]
        [ ]


formDescription : Signal.Address Action -> Model -> Html.Html
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


inputDescription : Signal.Address Action -> Model -> Html.Html
inputDescription address model =
  textarea  [
              class "field-light col col-12",
              value model.description,
              placeholder "Fill the description of coach",
              cols 12,
              rows 5
            ]
            [ ]


saveBtn : Signal.Address Action -> Model -> Html.Html
saveBtn address model =
  button  [
            class "btn regular"
          ]
          [
            i [ class "fa fa-floppy-o mr1" ]
              [ ],
            text "Save coach"
          ]
