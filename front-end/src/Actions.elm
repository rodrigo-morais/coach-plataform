module Actions (..) where


import Router.Routing as Routing


import Coaches.Edit.Actions as CoachesEditActions
import Coaches.Search.Actions as CoachesSearchActions


type Action =
  NoOp
  | RoutingAction Routing.Action
  | CoachesEditAction CoachesEditActions.Action
  | CoachesSearchAction CoachesSearchActions.Action