defmodule Menu.Repo do
  use Ecto.Repo, adapter: Ecto.Adapters.Postgres

  def conf do
    database = Application.get_env(:phoenix, :database)
    parse_url "ecto://al:t0t0@localhost/#{database}" 
  end 

  def priv do
    app_dir(:menu, "priv/repo")
  end
end
