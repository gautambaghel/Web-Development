defmodule Tasktracker.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false, unique: true
      add :name, :string
      add :password_hash, :string

      timestamps()
    end

  end
end
