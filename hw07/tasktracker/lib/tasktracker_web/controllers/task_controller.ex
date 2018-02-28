  defmodule TasktrackerWeb.TaskController do
    use TasktrackerWeb, :controller

    alias Tasktracker.Activity
    alias Tasktracker.Activity.Task

    def index(conn, _params) do   
      user_id = get_session(conn, :user_id)
      user = Tasktracker.Accounts.get_user(user_id || -1)
      if user == nil do
        conn
          |> put_flash(:info, "User not logged in")
          |> redirect(to: page_path(conn, :index))
      end
      tasks = Activity.list_tasks_by_email(user.email)
      tasks_assigned = Activity.list_tasks_by_id(user_id)

      list_tasks_assigned = Activity.list_tasks_id_for(user_id)

      timeblock = list_tasks_assigned
      |> Enum.map(&({&1, workingOnTask(&1) }))
      |> Enum.into(%{})

      last_timeblock_ids = list_tasks_assigned
      |> Enum.map(&({&1, lastTimeBlockId(&1) }))
      |> Enum.into(%{})

      render(conn, "index.html", tasks: tasks, tasks_assigned: tasks_assigned, timeblock: timeblock, last_timeblock_ids: last_timeblock_ids)
    end

    def workingOnTask(task_id) do

      case Map.fetch(Activity.last_timeblock_for(task_id), task_id) do
        {:ok, value} -> 
            if value.year == 2000 do
              true
            else
              false
            end
        :error       -> false
      end

    end

    def lastTimeBlockId(task_id) do
      
      case Map.fetch(Activity.last_timeblock_id_for(task_id), task_id) do
        {:ok, value} -> 
            elem(Map.fetch(Activity.last_timeblock_id_for(task_id), task_id) ,1)
        :error       -> 0
      end

    end

    def new(conn, _params) do
      changeset = Activity.change_task(%Task{})
      id = get_session(conn, :user_id)
      manages = Activity.get_managees_for(id)
      render(conn, "new.html", changeset: changeset, managees: manages)
    end

    def create(conn, %{"task" => task_params}) do
      case Activity.create_task(task_params) do
        {:ok, task} ->
          conn
          |> put_flash(:info, "Task created successfully.")
          |> redirect(to: task_path(conn, :show, task))
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
      timeblocks = Activity.timeblocks_map_for(id)
      IO.inspect task.timeblocks
      render(conn, "edit.html", task: task, changeset: changeset, timeblocks: timeblocks)
    end

    def update(conn, %{"id" => id, "task" => task_params}) do
      task = Activity.get_task!(id)

      case Activity.update_task(task, task_params) do
        {:ok, task} ->
          conn
          |> put_flash(:info, "Task updated successfully.")
          |> redirect(to: task_path(conn, :show, task))
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
