class UsersController < ApplicationController
  def index

  end

  def show

  end

  def edit
    render "users/#{params[:name]}", locals: {user: current_user }
  end
end
