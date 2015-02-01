defmodule MenuTest do
  use ExUnit.Case, async: true
  use Plug.Test

  @opts Menu.Router.init([])

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

end
