defmodule DemoElixirPhoenixWeb.UserHTML do
  use DemoElixirPhoenixWeb, :html

  embed_templates "user_html/*"

  @doc """
  Renders a user form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def user_form(assigns)
end
