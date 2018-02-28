defmodule Tasktracker.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :name, :string, null: false
      add :description, :text
      add :time_spent, :integer
      add :completed, :boolean, default: false, null: false
      add :user_id, references(:users, on_delete: :delete_all), null: false
      add :user_email_assigned, :string, null: false

      timestamps()
    end

    create index(:tasks, [:user_id])
  end
end
