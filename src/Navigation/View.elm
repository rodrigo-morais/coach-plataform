module Navigation.View (..) where


import Html exposing (..)
import Html.Attributes exposing (class, style)


view : Html.Html
view =
  nav


nav : Html.Html
nav =
  div 
    [ class "clearfix mb2 white bg-black", style [("min-height", "3.5em")]  ]
    [ div 
        [ class "left p2 col col-10" ]
        [ listCoaches
        , newCoach
        , editCoach
        ]
    ]


listCoaches : Html.Html
listCoaches =
  div [ class "col col-1 border border-white rounded p1 px2 mr2" ]
      [ i [ class "fa fa-users mr1" ]
          [ ]
      , text "List"
      ]


newCoach : Html.Html
newCoach =
  div [ class "col col-1 border border-white rounded p1 mr2" ]
      [ i [ class "fa fa-user-plus mr1"]
          [ ]
      , text "New"
      ]


editCoach : Html.Html
editCoach =
  div [ class "col col-1 border border-white rounded p1 px2 mr2" ]
      [ i [ class "fa fa-pencil-square-o mr1"]
          [ ]
      , text "Edit"
      ]