module Navigation.View (..) where


import Html exposing (..)
import Html.Attributes exposing (class, style, href)


import Models exposing (..)


view : AppModel -> Html.Html
view model =
  nav model


nav : AppModel -> Html.Html
nav model =
  div 
    [ class "clearfix mb2 white bg-black", style [("min-height", "3.5em")]  ]
    [ div 
        [ class "left p2 col col-10" ]
        [ listCoaches model
        , newCoach model
        ]
    ]


listCoaches : AppModel -> Html.Html
listCoaches model =
  let
    (stl, cls) =
      styles model "search"

  in
    a [ href "#/coaches/search", class "text-decoration-none", style [stl] ]
      [ div [ class cls ]
            [ i [ class "fa fa-users ml1 mr1" ]
                [ ]
            , text "List"
            ]
      ]


newCoach : AppModel -> Html.Html
newCoach model =
  let
    (stl, cls) =
      styles model "new"

  in
    a [ href "#/coaches/new", class "text-decoration-none", style [stl] ]
      [ div [ class cls ]
            [ i [ class "fa fa-user-plus ml1 mr1 normal", style [("width", "1em")]]
                [ ]
            , text "New"
            ]
      ]


styles : AppModel -> String -> ((String, String), String)
styles model route =
  let
    routeModel =
      model.routeModel

    location =
      routeModel.location

    path =
      location.path

    maybeList =
      List.foldl (::) [] path
      |> List.head

    (stl, cls) =
      case maybeList of
        Just lst ->
          if lst == route then
            (("color", "#0074d9"), "col col-1 border border-blue rounded p1 mr2")
          else
            (("color", "#ffffff"), "col col-1 border border-white rounded p1 mr2")

        Nothing ->
          (("color", "#ffffff"), "col col-1 border border-white rounded p1 mr2")
  in
    (stl, cls)