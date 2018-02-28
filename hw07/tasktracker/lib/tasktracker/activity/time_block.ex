defmodule Tasktracker.Activity.TimeBlock do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Activity.TimeBlock


  schema "timeblocks" do
    field :time_beg, :naive_datetime
    field :time_end, :naive_datetime
    field :task_id, :id

    timestamps()
  end

  @doc false
  def changeset(%TimeBlock{} = time_block, attrs) do
    time_block
    |> cast(attrs, [:time_beg, :time_end, :task_id])
    |> validate_required([:time_beg, :time_end, :task_id])
  end
end
