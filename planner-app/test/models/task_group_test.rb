require "test_helper"

class TaskGroupTest < ActiveSupport::TestCase
  setup do
    @task_group = TaskGroup.new(title: "test")
  end

  test "is valid" do
    assert @task_group.valid?
  end

  test "requires a title" do
    @task_group.title = nil
    assert_not @task_group.valid?
    assert_includes @task_group.errors, :title
  end
end
