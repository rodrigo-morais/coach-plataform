module Coaches.Edit.Models (..) where


type alias CoachId = Int


type alias Coach =
    {
        id: CoachId,
        spots: Int,
        name: String,
        mentor: Bool,
        coach: Bool,
        capabilities: String,
        description: String
    }


initialCoach : Coach
initialCoach =
    {
        id = 0,
        spots = 0,
        name = "",
        mentor = False,
        coach = False,
        capabilities = "",
        description = ""
    }

type MessageType =
  Blank
  | Error
  | Success


type alias Message =
  {
    messageType : MessageType,
    text : String
  }


initialMessage : Message
initialMessage =
  {
    messageType = Blank,
    text = ""
  }


type alias ViewModel =
  {
    coach : Coach,
    message : Message
  }


initialViewModel =
  {
    coach = initialCoach,
    message = initialMessage
  }
