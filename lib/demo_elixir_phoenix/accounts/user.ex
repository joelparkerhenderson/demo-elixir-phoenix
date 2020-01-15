defmodule DemoElixirPhoenix.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :about, :string
    field :birth_date, :date
    field :email, :string
    field :name, :string
    field :phone, :string
    field :photo_uri, :string
    field :web, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :phone, :web, :birth_date, :photo_uri, :about])
    |> validate_required([:name, :email, :phone, :web, :birth_date, :photo_uri, :about])
  end
end
