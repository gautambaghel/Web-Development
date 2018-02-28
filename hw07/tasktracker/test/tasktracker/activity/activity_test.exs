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

  describe "manages" do
    alias Tasktracker.Activity.Manage

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def manage_fixture(attrs \\ %{}) do
      {:ok, manage} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Activity.create_manage()

      manage
    end

    test "list_manages/0 returns all manages" do
      manage = manage_fixture()
      assert Activity.list_manages() == [manage]
    end

    test "get_manage!/1 returns the manage with given id" do
      manage = manage_fixture()
      assert Activity.get_manage!(manage.id) == manage
    end

    test "create_manage/1 with valid data creates a manage" do
      assert {:ok, %Manage{} = manage} = Activity.create_manage(@valid_attrs)
    end

    test "create_manage/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activity.create_manage(@invalid_attrs)
    end

    test "update_manage/2 with valid data updates the manage" do
      manage = manage_fixture()
      assert {:ok, manage} = Activity.update_manage(manage, @update_attrs)
      assert %Manage{} = manage
    end

    test "update_manage/2 with invalid data returns error changeset" do
      manage = manage_fixture()
      assert {:error, %Ecto.Changeset{}} = Activity.update_manage(manage, @invalid_attrs)
      assert manage == Activity.get_manage!(manage.id)
    end

    test "delete_manage/1 deletes the manage" do
      manage = manage_fixture()
      assert {:ok, %Manage{}} = Activity.delete_manage(manage)
      assert_raise Ecto.NoResultsError, fn -> Activity.get_manage!(manage.id) end
    end

    test "change_manage/1 returns a manage changeset" do
      manage = manage_fixture()
      assert %Ecto.Changeset{} = Activity.change_manage(manage)
    end
  end

  describe "timeblocks" do
    alias Tasktracker.Activity.TimeBlock

    @valid_attrs %{time_beg: ~N[2010-04-17 14:00:00.000000], time_end: ~N[2010-04-17 14:00:00.000000]}
    @update_attrs %{time_beg: ~N[2011-05-18 15:01:01.000000], time_end: ~N[2011-05-18 15:01:01.000000]}
    @invalid_attrs %{time_beg: nil, time_end: nil}

    def time_block_fixture(attrs \\ %{}) do
      {:ok, time_block} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Activity.create_time_block()

      time_block
    end

    test "list_timeblocks/0 returns all timeblocks" do
      time_block = time_block_fixture()
      assert Activity.list_timeblocks() == [time_block]
    end

    test "get_time_block!/1 returns the time_block with given id" do
      time_block = time_block_fixture()
      assert Activity.get_time_block!(time_block.id) == time_block
    end

    test "create_time_block/1 with valid data creates a time_block" do
      assert {:ok, %TimeBlock{} = time_block} = Activity.create_time_block(@valid_attrs)
      assert time_block.time_beg == ~N[2010-04-17 14:00:00.000000]
      assert time_block.time_end == ~N[2010-04-17 14:00:00.000000]
    end

    test "create_time_block/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Activity.create_time_block(@invalid_attrs)
    end

    test "update_time_block/2 with valid data updates the time_block" do
      time_block = time_block_fixture()
      assert {:ok, time_block} = Activity.update_time_block(time_block, @update_attrs)
      assert %TimeBlock{} = time_block
      assert time_block.time_beg == ~N[2011-05-18 15:01:01.000000]
      assert time_block.time_end == ~N[2011-05-18 15:01:01.000000]
    end

    test "update_time_block/2 with invalid data returns error changeset" do
      time_block = time_block_fixture()
      assert {:error, %Ecto.Changeset{}} = Activity.update_time_block(time_block, @invalid_attrs)
      assert time_block == Activity.get_time_block!(time_block.id)
    end

    test "delete_time_block/1 deletes the time_block" do
      time_block = time_block_fixture()
      assert {:ok, %TimeBlock{}} = Activity.delete_time_block(time_block)
      assert_raise Ecto.NoResultsError, fn -> Activity.get_time_block!(time_block.id) end
    end

    test "change_time_block/1 returns a time_block changeset" do
      time_block = time_block_fixture()
      assert %Ecto.Changeset{} = Activity.change_time_block(time_block)
    end
  end
end
