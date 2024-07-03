defmodule DemoElixirPhoenix.AccountFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DemoElixirPhoenix.Account` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        email: "some email",
        name: "some name"
      })
      |> DemoElixirPhoenix.Account.create_user()

    user
  end
end
