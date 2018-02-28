defmodule Tasktracker.Activity.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Activity.Task
  alias Tasktracker.Activity.TimeBlock


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :name, :string
    field :time_spent, :integer
    belongs_to :user, Tasktracker.Accounts.User
    field :user_email_assigned, :string
    has_many :timeblocks, TimeBlock, foreign_key: :id

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :description, :time_spent, :completed, :user_id, :user_email_assigned])
    |> validate_required([:name, :description, :time_spent, :completed, :user_id, :user_email_assigned])
  end
end
