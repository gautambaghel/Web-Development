defmodule Tasktraker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string
      add :description, :text
      add :time, :integer, default: 15
      add :completed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :user_id_assigned, :integer, null: false

      timestamps()
    end

    create index(:tasks, [:user_id])
  end
end
