class UsersController < ApplicationController
  def index

  end

  def show

  end

  def edit
    render "users/edit/#{params[:name]}"
  end

  def new
    render "users/new/#{params[:name]}"
  end
end
