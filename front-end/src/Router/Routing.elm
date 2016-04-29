module Router.Routing (..) where


import Hop
import Hop.Matchers exposing (match1, match3, int)
import Hop.Types exposing (Router, PathMatcher)


import Task exposing (Task)


import Router.Models exposing (..)
import Router.Actions exposing (..)
import Router.Update exposing (..)


type alias RouteModel = Router.Models.RouteModel
type alias Route = Router.Models.Route
initialRouteModel : RouteModel
initialRouteModel = Router.Models.initialRouteModel


type alias Action = Router.Actions.Action


update = Router.Update.update


indexMatcher : PathMatcher Route
indexMatcher =
  match1 CoachesSearchRoute "/"


coachesEditMatcher : PathMatcher Route
coachesEditMatcher =
  match3 CoachesEditRoute "/coaches/" int "/edit"


coachesNewMatcher : PathMatcher Route
coachesNewMatcher =
  match1 CoachesNewRoute "/coaches/new"


coachesSearchMatcher : PathMatcher Route
coachesSearchMatcher =
  match1 CoachesSearchRoute "/coaches/search"


matchers : List (PathMatcher Route)
matchers =
  [ indexMatcher
  , coachesEditMatcher
  , coachesNewMatcher
  , coachesSearchMatcher
  ]


router : Router Route
router =
  Hop.new
    { matchers = matchers
    , notFound = NotFoundRoute
    }


run : Task () ()
run =
  router.run


signal : Signal Action
signal =
  Signal.map ApplyRoute router.signal