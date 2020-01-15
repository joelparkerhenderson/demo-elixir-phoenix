defmodule Demo.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :about, :string
    field :email, :string
    field :name, :string
    field :phone, :string
    field :web, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone, :web, :about])
    |> validate_required([:name, :email, :phone, :web, :about])
  end
end
