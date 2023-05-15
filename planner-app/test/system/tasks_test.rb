require "application_system_test_case"

class TasksTest < ApplicationSystemTestCase
  setup do
    @task_group = TaskGroup.create!(title: "Test Group")
    @task = @task_group.tasks.create!(title: "Test Task")
  end

  test "listing tasks" do
    visit task_group_url(@task_group)
    assert_selector "h2", text: @task.title
  end

  test "creating a task" do
    title = "hello world"
    due_date = 2.days.from_now
    visit task_group_url(@task_group)

    assert_no_text title
    assert_no_text due_date
    click_link "New task"

    fill_in "Title", with: title
    fill_in "Due at", with: due_date
    click_button "Create Task"

    assert_text "Task was successfully created"
    assert_selector "h2", text: title
    assert_text due_date.strftime("%Y-%m-%d %H:%M:00 %Z")
  end

  test "completing a task" do
    visit task_group_url(@task_group)

    assert_no_text "Incomplete"

    click_button "Complete"

    assert_text "Task was successfully updated."
    assert_text "Incomplete"
    assert_no_text "Complete"
  end

  test "incompleting a task" do
    @task.update!(completed: true)
    visit task_group_url(@task_group)

    assert_no_text "Complete"

    click_button "Incomplete"

    assert_text "Task was successfully updated."
    assert_text "Complete"
    assert_no_text "Incomplete"
  end

  test "editing a task" do
    original_title = @task.title
    new_title = "i have a new title"

    visit task_group_url(@task_group)
    assert_no_text new_title

    click_link "Edit"
    fill_in "Title", with: new_title
    click_button "Update Task"

    assert_text "Task was successfully updated."
    assert_selector "h2", text: new_title
    assert_no_text original_title
  end

  test "deleting a task" do
    visit edit_task_group_task_url(@task_group, @task)
    accept_confirm do
      click_button "Destroy this task"
    end

    assert_text "Task was successfully destroyed."
    assert_no_text @task.title
  end
end
