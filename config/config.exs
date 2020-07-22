# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :demo_elixir_phoenix,
  ecto_repos: [DemoElixirPhoenix.Repo]

# Configures the endpoint
config :demo_elixir_phoenix, DemoElixirPhoenixWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OBbWwZBYwAD1CLXZsuiKY1buqf/edpwT8VfL7ZAw+1UD8jGqOGH9vdJktYaBEMyX",
  render_errors: [view: DemoElixirPhoenixWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DemoElixirPhoenix.PubSub,
  live_view: [signing_salt: "DWxOrTvj"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
