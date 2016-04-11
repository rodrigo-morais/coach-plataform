module Coaches.Edit.Models (..) where


import Coaches.Models as CoachesModel


type alias Coach = CoachesModel.Coach

type MessageType =
  Blank
  | Error
  | Success


type alias Message =
  { messageType : MessageType
  , text : String
  }


initialMessage : Message
initialMessage =
  { messageType = Blank
  , text = ""
  }


type alias ViewModel =
  { coach : Coach
  , message : Message
  }


initialViewModel =
  { coach = CoachesModel.initialCoach
  , message = initialMessage
  }
