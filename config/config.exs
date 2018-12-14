# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :loa_of_loot,
  ecto_repos: [LoaOfLoot.Repo],
  wcl_api_key: System.get_env("WARCRAFT_LOGS_API_KEY")

# Configures the endpoint
config :loa_of_loot, LoaOfLootWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base:
    "L1uKIE4Ve0vHRnv2Su4fMtBMmVupdPk3VkvaieNQGC8VMRWjEfMB3nWRt9iyqQwu",
  render_errors: [view: LoaOfLootWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: LoaOfLoot.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
