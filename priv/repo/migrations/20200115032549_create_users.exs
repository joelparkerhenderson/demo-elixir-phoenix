defmodule DemoElixirPhoenix.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      timestamps()
      add :name, :string
      add :email, :string
      add :phone, :string
      add :web, :string
      add :birth_date, :date
      add :photo_uri, :string
      add :about, :text
   end

  end
end
