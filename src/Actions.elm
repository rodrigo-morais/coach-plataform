module Actions (..) where


import Router.Routing as Routing


import Coaches.Edit.Actions as CoachesEditActions


type Action =
  NoOp
  | RoutingAction Routing.Action
  | CoachesEditAction CoachesEditActions.Action