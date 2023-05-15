require "test_helper"

class TaskGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_group = TaskGroup.create!(title: "Test")
  end

  test "should get index" do
    get task_groups_url
    assert_response :success
  end

  test "should get show" do
    get task_group_url(@task_group.id)
    assert_response :success
  end

  test "should get new" do
    get new_task_group_url
    assert_response :success
  end

  test "should create new task groups" do
    group_title = "I am a task group"

    assert_difference -> { TaskGroup.count }, 1 do
      post(
        task_groups_url,
        params: { task_group: { title: group_title } }
      )
    end

    created_task_group = TaskGroup.last
    assert_redirected_to task_group_url(created_task_group)
    assert_equal(group_title, created_task_group.title)
  end

  test "should get edit" do
    get edit_task_group_url(@task_group.id)
    assert_response :success
  end

  test "should update existing task groups" do
    new_title = "i have changed"

    assert_changes -> { @task_group.reload.title }, to: new_title do
      put(
        task_group_url(@task_group),
        params: { task_group: { title: new_title } }
      )
    end
    assert_redirected_to task_group_url(@task_group)
  end

  test "should delete task groups" do
    assert_difference -> { TaskGroup.count }, -1 do
      delete task_group_url(@task_group)
    end
    assert_redirected_to task_groups_url
    assert_raises(ActiveRecord::RecordNotFound) { @task_group.reload }
  end
end
