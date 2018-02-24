defmodule Tasktracker.Activity.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Activity.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :name, :string
    field :time_beg, :naive_datetime
    field :time_end, :naive_datetime
    belongs_to :user, Tasktracker.Accounts.User
    field :user_email_assigned, :string

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :description, :time_beg, :time_end, :completed, :user_id, :user_email_assigned])
    |> validate_required([:name, :description, :time_beg, :time_end, :completed, :user_id, :user_email_assigned])
  end
end
