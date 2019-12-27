class UsersController < ApplicationController
  def index

  end

  def new
    render "users/new/#{params[:name]}"
  end

  def show

  end



  def edit
    render "users/edit/#{params[:name]}"
  end

  
end
