class UsersController < ApplicationController

  def show
    @user = User.find(params[:id]) 
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
     @user = User.find(params[:id])
     @user.update(nickname:  user_params[:nickname],introduction: user_params[:introduction])
     redirect_to root_path
  end


  def item_exhibit
    @user = User.find(params[:id])
  end

  def item_negotiate
    @user = User.find(params[:id])
  end
  
  def item_buyed
    @user = User.find(params[:id])
    asdfghj
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :introduction)
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
