defmodule DemoElixirPhoenixWeb.PageController do
  use DemoElixirPhoenixWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
