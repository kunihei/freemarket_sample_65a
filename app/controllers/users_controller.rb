class UsersController < ApplicationController
  def index

  end
  def create

    render "users/new/#{params[:name]}"
  end

  def show

  end
  
  def new
    render "users/new/#{params[:name]}"
  end

  def edit
    render "users/edit/#{params[:name]}"
  end

  def item_exhibit
    @user = User.find(params[:id])
  end

  def item_negotiate
    @user = User.find(params[:id])
  end

end
