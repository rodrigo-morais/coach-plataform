module Configuration.Models (..) where

type alias Configuration =
  { ip: String
  , ipPort: String
  }

initialConfiguration : Configuration
initialConfiguration =
  { ip = "localhost"
  , ipPort = "4000"
  }