class TaskGroupsController < ApplicationController
  before_action :set_task_group, except: [:index]

  def index
    @task_groups = TaskGroup.all
  end

  def create
    if @task_group.save
      redirect_to(
        task_group_url(@task_group),
        notice: "Task group was successfully created."
      )
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @task_group.update(task_group_params)
      redirect_to(
        task_group_url(@task_group),
        notice: "Task group was successfully updated."
      )
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task_group.destroy!
    redirect_to task_groups_url, notice: "Task group was successfully destroyed."
  end

  private

  def task_group_params
    params.require(:task_group).permit(:title)
  end

  def set_task_group
    @task_group = if params[:id]
                    TaskGroup.find(params[:id])
                  elsif action_name == "create"
                    TaskGroup.new(task_group_params)
                  else
                    TaskGroup.new
                  end
  end
end
