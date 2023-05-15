require "test_helper"

class TaskTest < ActiveSupport::TestCase
  setup do
    task_group = TaskGroup.new(title: "test")
    @task = Task.new(title: "Do the thing", task_group: task_group)
  end

  test "is valid" do
    assert @task.valid?
  end

  test "requires a title" do
    @task.title = nil
    assert_not @task.valid?
    assert_includes @task.errors, :title
  end
end
