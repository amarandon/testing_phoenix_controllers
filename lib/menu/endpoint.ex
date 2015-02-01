defmodule Menu.Endpoint do
  use Phoenix.Endpoint, otp_app: :menu

  plug Plug.Static,
    at: "/", from: :menu

  plug Plug.Logger

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_menu_key",
    signing_salt: "D9UJbIJL",
    encryption_salt: "ii3lgL7L"

  plug :router, Menu.Router
end
