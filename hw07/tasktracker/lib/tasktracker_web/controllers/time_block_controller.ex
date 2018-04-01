defmodule TasktrackerWeb.TimeBlockController do
  use TasktrackerWeb, :controller

  alias Tasktracker.Activity
  alias Tasktracker.Activity.TimeBlock

  action_fallback TasktrackerWeb.FallbackController

  def index(conn, _params) do
    timeblocks = Activity.list_timeblocks()
    render(conn, "index.json", timeblocks: timeblocks)
  end

  def create(conn, %{"time_block" => time_block_params}) do
    with {:ok, %TimeBlock{} = time_block} <- Activity.create_time_block(time_block_params) do
    IO.puts "reached here"
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_block_path(conn, :show, time_block))
      |> render("show.json", time_block: time_block)
    end
  end

  def show(conn, %{"id" => id}) do
    time_block = Activity.get_time_block!(id)
    render(conn, "show.json", time_block: time_block)
  end

  def update(conn, %{"id" => id, "time_block" => time_block_params}) do
    time_block = Activity.get_time_block!(id)

    with {:ok, %TimeBlock{} = time_block} <- Activity.update_time_block(time_block, time_block_params) do
      render(conn, "show.json", time_block: time_block)
    end
  end

  def delete(conn, %{"id" => id}) do
    time_block = Activity.get_time_block!(id)
    with {:ok, %TimeBlock{}} <- Activity.delete_time_block(time_block) do
      send_resp(conn, :no_content, "")
    end
  end
end
