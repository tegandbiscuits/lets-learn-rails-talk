require "application_system_test_case"

class TaskGroupsTest < ApplicationSystemTestCase
  setup do
    @task_group = TaskGroup.create!(title: "Test Group")
  end

  test "visiting the index" do
    visit task_groups_url
    assert_selector "h1", text: "Task Groups"
    assert_link @task_group.title
  end

  test "showing a task group" do
    visit task_groups_url
    assert_no_selector "h1", text: @task_group.title
    click_link @task_group.title
    assert_selector "h1", text: @task_group.title
  end

  test "creating a task group" do
    visit new_task_group_url

    title = "A new task group"
    fill_in "Title", with: title
    click_button "Create Task group"

    assert_text "Task group was successfully created."
    assert_selector "h1", text: title
  end

  test "editing a task group" do
    visit edit_task_group_url(@task_group)

    original_title = @task_group.title
    new_title = "the new title"
    fill_in "Title", with: new_title
    click_button "Update Task group"

    assert_text "Task group was successfully updated."
    assert_selector "h1", text: new_title

    visit task_groups_url
    assert_no_text original_title
    assert_link new_title
  end

  test "deleting a task group" do
    visit edit_task_group_url(@task_group)
    accept_confirm do
      click_button "Destroy this task group"
    end

    assert_text "Task group was successfully destroyed."
    assert_no_text @task_group.title
  end
end
