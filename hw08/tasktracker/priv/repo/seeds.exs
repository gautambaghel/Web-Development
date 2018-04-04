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
    p = Comeonin.Argon2.hashpwsalt("password1")

    Repo.delete_all(User)
    a = Repo.insert!(%User{ email: "alice@gmail.com", name: "alice", password_hash: p})
    b = Repo.insert!(%User{ email: "bob@gmail.com", name: "bob", password_hash: p })
    c = Repo.insert!(%User{ email: "carol@gmail.com", name: "carol", password_hash: p })
    d = Repo.insert!(%User{ email: "dave@gmail.com", name: "dave", password_hash: p })

    Repo.delete_all(Task)
    Repo.insert!(%Task{ user_id: a.id, title: "HW08" , description: "Do this homework!", user_email_assigned: a.email, time_spent: 0 })
    Repo.insert!(%Task{ user_id: b.id, title: "Redux" , description: "Incorporate redux in to th SPA", user_email_assigned: a.email, time_spent: 0 })
    Repo.insert!(%Task{ user_id: b.id, title: "Password" , description: "Implement password encription", user_email_assigned: a.email, time_spent: 0 })
    Repo.insert!(%Task{ user_id: c.id, title: "Encription" , description: "Hash and storing the password", user_email_assigned: b.email, time_spent: 0 })
    Repo.insert!(%Task{ user_id: d.id, title: "Https" , description: "Secure connection", user_email_assigned: c.email, time_spent: 0  })
  end
end

Seeds.run
