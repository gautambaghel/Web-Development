defmodule TasktrakerWeb.TaskController do
  use TasktrakerWeb, :controller

  alias Tasktraker.Activity
  alias Tasktraker.Activity.Task

"""
  def index(conn, _params) do
    tasks = Activity.list_tasks()
    render(conn, "index.html", tasks: tasks)
  end


    user = Accounts.get_user!(id)
    render(conn, "list.html", user: user)
"""

  def index(conn, _params) do
    user_id = get_session(conn, :user_id)
    user = Tasktraker.Accounts.get_user(user_id || -1)
    if user == nil do
      conn
        |> put_flash(:info, "User not logged in")
        |> redirect(to: page_path(conn, :index))
    end
    tasks = Activity.list_tasks_by_email(user.email)
    tasks_assigned = Activity.list_tasks_by_id(user_id)

    render(conn, "index.html", tasks: tasks, tasks_assigned: tasks_assigned)
  end


  def new(conn, _params) do
    changeset = Activity.change_task(%Task{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"task" => task_params}) do
    case Activity.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task created successfully.")
        |> redirect(to: task_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Activity.get_task!(id)
    render(conn, "show.html", task: task)
  end

  def edit(conn, %{"id" => id}) do
    task = Activity.get_task!(id)
    changeset = Activity.change_task(task)
    render(conn, "edit.html", task: task, changeset: changeset)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Activity.get_task!(id)

    case Activity.update_task(task, task_params) do
      {:ok, task} ->
        conn
        |> put_flash(:info, "Task updated successfully.")
        |> redirect(to: task_path(conn, :index))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", task: task, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Activity.get_task!(id)
    {:ok, _task} = Activity.delete_task(task)

    conn
    |> put_flash(:info, "Task deleted successfully.")
    |> redirect(to: task_path(conn, :index))
  end
end
