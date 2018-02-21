defmodule TasktrakerWeb.PageController do
  use TasktrakerWeb, :controller
 
  alias Tasktraker.Accounts
  alias Tasktraker.Accounts.User

  def index(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "index.html", changeset: changeset)
  end

  def feed(conn, _params) do
    tasks = Tasktraker.Activity.list_tasks()
    changeset = Tasktraker.Activity.change_task(%Tasktraker.Activity.Task{})
    render conn, "feed.html", tasks: tasks, changeset: changeset
  end
end
