use Mix.Config

config :menu, Menu.Endpoint,
  http: [port: System.get_env("PORT") || 4001]

# Print only warnings and errors during test
config :logger, level: :warn

config :phoenix, :database, "menu_test"
