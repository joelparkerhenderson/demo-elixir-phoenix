defmodule DemoElixirPhoenix.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      timestamps()
      add :name, :string
      add :email, :string
    end

  end
end
