defmodule Tasktracker.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Tasktracker.Accounts.User
  alias Tasktracker.Activity.Manage

  schema "users" do
    field :email, :string
    field :name, :string
    has_many :manager_manages, Manage, foreign_key: :manager_id
    has_many :managee_manages, Manage, foreign_key: :managee_id
    has_many :managers, through: [:managee_manages, :manager]
    has_many :managees, through: [:manager_manages, :managee]

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :name])
    |> validate_required([:email, :name])
  end
end
