class UserPassController < ApplicationController
  before_action :set_user
  
  def update
    @user.update(user_password_params)
    sign_in(@user, bypass: true) 
    redirect_to root_path
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_password_params
    params.require(:user).permit(:email, :password)
  end
end
