class UserPassController < ApplicationController
  include SetUser
  before_action :set_user
  
  def update
    if  @user.update(user_password_params)
      sign_in(@user, bypass: true) 
      redirect_to "/users/mypage/mypage/#{current_user.id}"
    else
      redirect_to root_path, alert: '情報更新に失敗しました。'
    end
  end


  private
  def user_password_params
    params.require(:user).permit(:email, :password)
  end
end
