module Edit (..) where 


import StartApp 
import Effects exposing (Effects, Never)
import Task  


import Html exposing (..)
import Html.Attributes exposing (value, type', checked, rows, cols)


type alias CoachId = Int


type alias Model = 
    {
        id: CoachId,
        spots: Int,
        name: String,
        mentor: Bool,
        coach: Bool,
        capabilities: String,
        description: String
    }


init : (Model, Effects Action)
init =
    (
        {
            id = 0,
            spots = 0,
            name = "",
            mentor = False,
            coach = False,
            capabilities = "",
            description = ""
        }, 
        Effects.none
    )


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


type Action = 
    NoOp


update : Action -> Model -> (Model, Effects Action)
update action model = 
    case action of 
        NoOp -> (model, Effects.none)


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = []
    }


main =
    app.html


port runner : Signal (Task.Task Never ())
port runner =
  app.tasks