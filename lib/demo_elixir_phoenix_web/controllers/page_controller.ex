defmodule DemoElixirPhoenixWeb.PageController do
  use DemoElixirPhoenixWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
