defmodule MenuTest do
  import Ecto.Query
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Menu.Router.init([])

  setup do
    Mix.Tasks.Ecto.Migrate.run(["--all", "Menu.Repo"])
  
    on_exit fn ->
      Mix.Tasks.Ecto.Rollback.run(["--all", "Menu.Repo"])
    end
  end


  def with_session(conn) do
    session_opts = Plug.Session.init(store: :cookie, key: "_app",
                                     encryption_salt: "abc", signing_salt: "abc")
    conn
    |> Map.put(:secret_key_base, String.duplicate("abcdefgh", 8))
    |> Plug.Session.call(session_opts)
    |> Plug.Conn.fetch_session()
    |> Plug.Conn.fetch_params()
  end

  test "root URL" do
    # Create a test connection
    conn = with_session conn(:get, "/")
    
    # Invoke the plug
    conn = Menu.Router.call(conn, @opts)

    # Assert the response and status
    assert conn.state == :sent
    assert conn.status == 200
    assert String.contains?(conn.resp_body, "Hello Phoenix!")
  end

  test "create dish" do
    dish = %Menu.Dishes{
      title: "Pasta",
      description: "Delicious pasta",
      price: Decimal.new("8.50")
    }
    Menu.Repo.insert(dish)
    query = from dish in Menu.Dishes,
            order_by: [desc: dish.id],
            select: dish
    assert length(Menu.Repo.all(query)) == 1
  end

end
