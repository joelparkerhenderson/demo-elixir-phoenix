defmodule Demo.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :email, :string
      add :phone, :string
      add :web, :string
      add :about, :string

      timestamps()
    end

  end
end
