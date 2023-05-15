class TasksController < ApplicationController
  before_action :set_task_group
  before_action :set_task

  def create
    if @task.save
      redirect_to(
        task_group_url(@task_group),
        notice: "Task was successfully created."
      )
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      redirect_to(
        task_group_url(@task_group),
        notice: "Task was successfully updated."
      )
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy!
    redirect_to(
      task_group_url(@task_group),
      notice: "Task was successfully destroyed."
    )
  end

  private

  def set_task_group
    @task_group = TaskGroup.find(params[:task_group_id])
  end

  def set_task
    @task = if params[:id]
              @task_group.tasks.find(params[:id])
            elsif action_name == "create"
              @task_group.tasks.new(task_params)
            else
              @task_group.tasks.new
            end
  end

  def task_params
    params.require(:task).permit(:title, :due_at, :completed)
  end
end
