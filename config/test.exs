use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :loa_of_loot, LoaOfLootWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :loa_of_loot, LoaOfLoot.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "loa_of_loot_test",
  hostname: if(System.get_env("CI"), do: "postgres", else: "localhost"),
  pool: Ecto.Adapters.SQL.Sandbox

config :loa_of_loot,
  wcl_api_key: "test-key"
