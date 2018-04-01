# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Tasktracker.Repo.insert!(%Tasktracker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


defmodule Seeds do
  alias Tasktracker.Repo
  alias Tasktracker.Users.User
  alias Tasktracker.Tasks.Task

  def run do
    Repo.delete_all(User)
    a = Repo.insert!(%User{ name: "alice" })
    b = Repo.insert!(%User{ name: "bob" })
    c = Repo.insert!(%User{ name: "carol" })
    d = Repo.insert!(%User{ name: "dave" })

    Repo.delete_all(Task)
    Repo.insert!(%Task{ user_id: a.id, description: "Hi, I'm Alice" })
    Repo.insert!(%Task{ user_id: b.id, description: "Hi, I'm Bob" })
    Repo.insert!(%Task{ user_id: b.id, description: "Hi, I'm Bob Again" })
    Repo.insert!(%Task{ user_id: c.id, description: "Hi, I'm Carol" })
    Repo.insert!(%Task{ user_id: d.id, description: "Hi, I'm Dave" })
  end
end

Seeds.run
