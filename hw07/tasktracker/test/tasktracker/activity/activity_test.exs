defmodule Tasktracker.ActivityTest do
  use Tasktracker.DataCase

  alias Tasktracker.Activity

  describe "tasks" do
    alias Tasktracker.Activity.Task

    @valid_attrs %{completed: true, description: "some description", name: "some name", time_beg: ~N[2010-04-17 14:00:00.000000], time_end: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{completed: false, description: "some updated description", name: "some updated name", time_beg: ~N[2011-05-18 15:01:01.000000], time_end: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{completed: nil, description: nil, name: nil, time_beg: nil, time_end: nil}

    def task_fixture(attrs \\ %{}) do
      {:ok, task} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Activity.create_task()

      task
    end

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Activity.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Activity.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      assert {:ok, %Task{} = task} = Activity.create_task(@valid_attrs)
      assert task.completed == true
      assert task.description == "some description"
      assert task.name == "some name"
      assert task.time_beg == ~N[2010-04-17 14:00:00.000000]
      assert task.time_end == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activity.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      assert {:ok, task} = Activity.update_task(task, @update_attrs)
      assert %Task{} = task
      assert task.completed == false
      assert task.description == "some updated description"
      assert task.name == "some updated name"
      assert task.time_beg == ~N[2011-05-18 15:01:01.000000]
      assert task.time_end == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Activity.update_task(task, @invalid_attrs)
      assert task == Activity.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Activity.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Activity.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Activity.change_task(task)
    end
  end
end
