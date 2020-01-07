class UsersController < ApplicationController
  def index

  end
  def create
  
  end

  def show

  end
  
  def new
  
  end

  def edit
    render "users/edit/#{params[:name]}"
  end

end
