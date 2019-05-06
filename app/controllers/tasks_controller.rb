class TasksController < ApplicationController
  
  def index 
    @task = Task.all
  end
  
  def show
    @task = Task.find(params[:id])
  end
  
  def new
    @task = Task.new
  end
  
  def edit
    @task = Task.find(params[:id])
  end
  
  def create
    @task = Task.new(tasks_params)
    
    if @task.save
      flash[:success] = '正常に投稿されました'
      redirect_to @task
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
    @task = Task.find(params[:id])
    @task.destroy
    
    flash[:success] = '正常に削除されました'
    redirect_to tasks_url
  end
  
  
  
  private

  def tasks_params
    params.require(:task).permit(:content)
  end
  
end

