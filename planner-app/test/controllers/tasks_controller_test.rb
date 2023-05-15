require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @task_group = TaskGroup.create!(title: "Test group")
    @task = @task_group.tasks.create!(title: "I am a task")
  end

  test "should get new" do
    get new_task_group_task_url(@task_group)
    assert_response :success
  end

  test "should create new tasks" do
    freeze_time
    task_params = {
      title: "Do the thing",
      due_at: 2.days.from_now
    }

    assert_difference -> { @task_group.tasks.count }, 1 do
      post(
        task_group_tasks_url(@task_group),
        params: { task: task_params }
      )
    end
    assert_redirected_to task_group_url(@task_group)

    created_task = @task_group.tasks.last
    assert_equal(task_params[:title], created_task.title)
    assert_equal(task_params[:due_at], created_task.due_at)
  end

  test "should get edit" do
    get edit_task_group_task_url(@task_group, @task)
    assert_response :success
  end

  test "should update existing tasks" do
    assert_changes -> { @task.reload.completed }, to: true do
      patch(
        task_group_task_url(@task_group, @task),
        params: { task: { completed: true } }
      )
    end
    assert_redirected_to task_group_url(@task_group)
  end

  test "should destroy tasks" do
    assert_difference -> { @task_group.tasks.count }, -1 do
      delete task_group_task_url(@task_group, @task)
    end
    assert_redirected_to task_group_url(@task_group)
    assert_raises(ActiveRecord::RecordNotFound) { @task.reload }
  end
end
