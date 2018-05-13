use Mix.Config

config :thatOnePlace, ecto_repos: [ThatOnePlace.Repo]

import_config "#{Mix.env}.exs"
