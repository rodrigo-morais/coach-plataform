module Coaches.Edit.Edit (..) where 

import Html exposing (..)
import Html.Attributes exposing (value, type', checked, rows, cols)


import Coaches.Edit.Models exposing (..)
import Coaches.Edit.Actions exposing (..)


view : Signal.Address Action -> Model -> Html
view address model =
    div [] 
        [ 
            formSpots address model,
            formName address model,
            formType address model,
            formCapabilities address model,
            formDescription address model
        ]


formSpots : Signal.Address Action -> Model -> Html
formSpots address model =
    div [] 
        [
            div [] [text "Spots:"],
            input [value (toString model.spots)] []
        ]


formName : Signal.Address Action -> Model -> Html
formName address model =
    div [] 
        [
            div [] [text "Name:"],
            input [value model.name] []
        ]


formType : Signal.Address Action -> Model -> Html
formType address model =
    div []
        [
            div [] [text "Mentor:"],
            input [type' "checkbox", checked model.mentor] [],
            div [] [text "Coach:"],
            input [type' "checkbox", checked model.coach] []
        ]


formCapabilities : Signal.Address Action -> Model -> Html
formCapabilities address model =
    div [] 
        [
            div [] [text "Capabilities:"],
            input [value model.capabilities] []
        ]


formDescription : Signal.Address Action -> Model -> Html
formDescription address model =
    div [] 
        [
            div [] [text "description:"],
            textarea 
                [
                    value model.description,
                    cols 12,
                    rows 5
                ] 
                []
        ]
