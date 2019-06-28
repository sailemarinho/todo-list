class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.create(task_params)

    redirect_to task_path(@task)
  end

  def edit
  end

  def update
    @task.update(task_params)
    event = Event.new
    # color = i%['#7B68EE', '#800000', '#2F4F
    if @task.completed
      event.user_data = { Congratulations: { color: "blue", message: "boa"} }
      flash[:notice] = ['Congratulations!', 'Nice job!', 'Good Work!', 'Nicely done!', 'Way to go!'].sample
    else
      event.user_data = { Shame: { color: "blue", message: "boa"} }
      flash[:notice] = ['Oops..!', 'You can do it!', 'Work hard!', 'What a pitty...', 'Try again...'].sample
    end
    event.task = @task
    event.save

    redirect_to task_path(@task)
  end

  def destroy
    @task.destroy

    redirect_to tasks_path
  end

  private

  def task_params
    params.require(:task).permit(:title, :details, :completed)
  end

  def set_task
    @task = Task.find(params[:id])
  end
end
