use Mix.Config

config :elixir_china, ElixirChina.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

config :elixir_china, ElixirChina.Repo,
  adapter: Ecto.Adapters.MySQL,
  database: "kbt",
  username: "root",
  password: "",
  hostname: "localhost"
  