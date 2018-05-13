use Mix.Config

# Configure your database
config :thatOnePlace, ThatOnePlace.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "titorthegod123",
  database: "thatoneplace_dev",
  hostname: "localhost",
  pool_size: 10
