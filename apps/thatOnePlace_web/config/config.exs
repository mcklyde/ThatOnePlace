# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :thatOnePlace_web,
  namespace: ThatOnePlaceWeb,
  ecto_repos: [ThatOnePlace.Repo]

# Configures the endpoint
config :thatOnePlace_web, ThatOnePlaceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "bEKNqvOwfNhVdTvQYOMNkZgVtoeDSK3iBf1/dYynfS+RMdoWkzHL1Ihe6CbArUak",
  render_errors: [view: ThatOnePlaceWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: ThatOnePlaceWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :thatOnePlace_web, :generators,
  context_app: :thatOnePlace

config :thatOnePlace_web, ThatOnePlaceWeb.AuthAccessPipeline,
  module: ThatOnePlaceWeb.UserAuth,
  error_handler: ThatOnePlaceWeb.AuthErrorHandler

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
