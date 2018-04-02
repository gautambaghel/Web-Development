defmodule TasktrackerWeb.TaskView do
  use TasktrackerWeb, :view
  alias TasktrackerWeb.TaskView
  alias TasktrackerWeb.UserView

  def render("index.json", %{tasks: tasks}) do
    %{data: render_many(tasks, TaskView, "task.json")}
  end

  def render("show.json", %{task: task}) do
    %{data: render_one(task, TaskView, "task.json")}
  end

  def render("task.json", %{task: task}) do
    %{id: task.id,
      time_spent: task.time_spent,
      completed: task.completed,
      description: task.description,
      title: task.title,
      user_email_assigned: task.user_email_assigned,
      user: render_one(task.user, UserView, "user.json")}
  end
end
