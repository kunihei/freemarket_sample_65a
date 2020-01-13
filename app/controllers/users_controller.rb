class UsersController < ApplicationController

  def show
    @user = User.find(current_user.id) 
  end


  def edit
    @user = User.find(params[:id]) 
    @address = @user.address
    if @user.id == current_user.id
      render "users/edit/#{params[:name]}" 
    else
      redirect_to root_path
    end
  end

  def update
     current_user.update(user_params)
  end


  def item_exhibit
    @user = User.find(current_user.id)
  end

  def item_negotiate
    @user = User.find(current_user.id)
  end


  def item_buyed
    @user = User.find(current_user.id)
  end

  def personal_details
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :introduction)
  end


end
