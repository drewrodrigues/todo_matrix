class TodosController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: Todo.all
  end

  def show
    render json: Todo.find(params[:id])
  end

  def create
    render json: Todo.create(todo_params)
  end

  def destroy
    Todo.find(params[:id]).destroy
    render json: {}, status: 200
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :priority, :details, :due, :position)
  end
end
