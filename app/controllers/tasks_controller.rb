class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
    
  def index 
   # @task = Task.all
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = current_user.tasks.build  # form_with 用
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def create
    @task = current_user.tasks.build(tasks_params)
    
    if @task.save
      flash[:success] = '正常に投稿されました'
      redirect_to root_url
    else
      flash.now[:alert] = '投稿できませんでした'
      render :new
    end
  end
  
  def update
    @task = Task.find(params[:id])
    
    if @task.update(tasks_params)
      flash[:success] = '正常に更新されました'
      redirect_to @task
    else
      flash.now[:alert] = '更新できませんでした'
      render :edit
    end
  end
  
  def destroy
    @task = current_user.tasks.find_by(id: params[:id])
    @task.destroy
    flash[:success] = '正常に削除されました'
    redirect_to root_url
  end
  
  
  
  private

  def tasks_params
    params.require(:task).permit(:content, :status)
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  
end

