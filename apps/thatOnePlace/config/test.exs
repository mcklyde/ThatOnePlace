use Mix.Config

# Configure your database
config :thatOnePlace, ThatOnePlace.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "thatoneplace_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
