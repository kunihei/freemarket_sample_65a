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

  def item_exhibit
    @user = User.find(params[:id])
  end

  def item_negotiate
    @user = User.find(params[:id])
  end

end
