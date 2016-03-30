module Coaches.Edit.Models (..) where 


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


initialModel : Model
initialModel =
    {
        id = 0,
        spots = 0,
        name = "",
        mentor = False,
        coach = False,
        capabilities = "",
        description = ""
    }


