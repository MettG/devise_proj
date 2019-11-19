class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]

  def index
    @tasks = current_user.tasks
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private
    def task_params
      params.require(:task).permit(:start, :due, :body)
    end

    # don't just find by the Account model or you may potentially be able to view other users accounts
    def set_task
      @task = current_user.tasks.find(params[:id])
    end
end
