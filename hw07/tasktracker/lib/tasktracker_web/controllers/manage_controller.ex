defmodule TasktrackerWeb.ManageController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Activity
  alias Tasktracker.Activity.Manage

  action_fallback TasktrackerWeb.FallbackController

  def index(conn, _params) do
    manages = Activity.list_manages()
    render(conn, "index.json", manages: manages)
  end

  def create(conn, %{"manage" => manage_params}) do
    with {:ok, %Manage{} = manage} <- Activity.create_manage(manage_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", manage_path(conn, :show, manage))
      |> render("show.json", manage: manage)
    end
  end

  def show(conn, %{"id" => id}) do
    manage = Activity.get_manage!(id)
    render(conn, "show.json", manage: manage)
  end

  def update(conn, %{"id" => id, "manage" => manage_params}) do
    manage = Activity.get_manage!(id)

    with {:ok, %Manage{} = manage} <- Activity.update_manage(manage, manage_params) do
      render(conn, "show.json", manage: manage)
    end
  end

  def delete(conn, %{"id" => id}) do
    manage = Activity.get_manage!(id)
    with {:ok, %Manage{}} <- Activity.delete_manage(manage) do
      send_resp(conn, :no_content, "")
    end
  end
end
