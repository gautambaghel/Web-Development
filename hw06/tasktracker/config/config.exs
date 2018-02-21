# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tasktraker,
  ecto_repos: [Tasktraker.Repo]

# Configures the endpoint
config :tasktraker, TasktrakerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "QbRaRul94SUXM/pzxJlpXFcBp0SgWUtiyjfuUHLE+F0qKkqEvYt591xf7WcqfXVK",
  render_errors: [view: TasktrakerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Tasktraker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
