# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :responda_me,
  namespace: Responda.Me,
  ecto_repos: [Responda.Me.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :responda_me, Responda.MeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "7fXcJCbGUdvKHDHHBQzipxzXVok79qBW1DGj4jqKiYyyPjWf/i6Ou2mhBvAOJe59",
  render_errors: [view: Responda.MeWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Responda.Me.PubSub,
  live_view: [signing_salt: "rJe8g70g"]

config :responda_me, Responda.Me.Guardian,
  issuer: "responda_me",
  secret_key: "00aVpIg/0RfPaXFbYB4lzy7nZiH9YyyUefbrs/f7IJ1Ir2xAoKjERRFwn8GG2ATj",
  ttl: {1, :day}

config :responda_me, Responda.MeWeb.AuthAccessPipeline,
  module: Responda.Me.Guardian,
  error_handler: Responda.MeWeb.AuthErrorHandler

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
