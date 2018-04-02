defmodule Tasktracker.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :title, :string
    field :time_spent, :integer
    belongs_to :user, Tasktracker.Users.User
    field :user_email_assigned, :string

    timestamps()
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :time_spent, :completed, :user_id, :user_email_assigned])
    |> validate_required([:title, :description, :time_spent, :completed, :user_id, :user_email_assigned])
  end
end
