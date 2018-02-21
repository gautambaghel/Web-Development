defmodule Tasktraker.Activity.Task do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktraker.Activity.Task


  schema "tasks" do
    field :completed, :boolean, default: false
    field :description, :string
    field :name, :string
    field :time, :integer
    belongs_to :user, Tasktraker.Accounts.User
    field :user_id_assigned, :string

    timestamps()
  end

  @doc false
  def changeset(%Task{} = task, attrs) do
    task
    |> cast(attrs, [:name, :description, :time, :completed, :user_id, :user_id_assigned])
    |> validate_required([:name, :description, :time, :completed, :user_id, :user_id_assigned])
  end
end
