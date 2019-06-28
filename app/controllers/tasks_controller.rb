class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]

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

  def flash_alert
    event = Event.new
    @color = ['#7B68EE', '#800000', '#2F4F4F', '#6A5ACD'].sample
    @message_congrats = ['Congratulations!', 'Nice job!', 'Good Work!', 'Nicely done!', 'Way to go!'].sample
    @message_shame = ['Oops..!', 'You can do it!', 'Work hard!', 'What a pitty...', 'Try again...'].sample

    if @task.completed
      flash[:notice] = @message_congrats
      event.user_data = { Congratulations: { color: @color, message: flash } }
    else
      flash[:notice] = @message_shame
      event.user_data = { Shame: { color: @color, message: flash } }
    end

    event.task = @task
    event.save
  end

  def update
    @task.update(task_params)

    flash_alert

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
