class Api::V1::TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token
  
  def index
    # todos = Todo.all.order(updated_at: "DESC")
    page = params[:page] || 1
    per = params[:per] || 5
    todos = Todo.page(page).per(per)
    total_pages = todos.total_pages
    response = {
      todos: todos.order(updated_at: "DESC"),
      total_pages: total_pages
    }
    render json: response
  end

  def create
    todo = Todo.new(todo_params)
    if todo.save
      render json: { status: 'SUCCESS', data: todo }
    else
      render json: { status: 'ERROR', data: todo.errors }
    end
  end

  def destroy
    @todo.destroy
    render json: { status: 'SUCCESS', message: 'Deleted the post', data: @todo}
  end

  def update
    if @todo.update(todo_params)
      render json: { status: 'SUCCESS', message: 'Updated the post', data: @todo }
    else
      render json: { status: 'SUCCESS', message: 'Not updated', data: @todo.errors }
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:id, :title, :body, :is_completed)
  end
end
