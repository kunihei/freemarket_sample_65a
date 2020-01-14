class UserPassController < ApplicationController
  include SetUser
  before_action :set_user
  
  def update
    if  @user.update(user_password_params)
      sign_in(@user, bypass: true) 
      flash[:notice] = "変更を保存しました"
      redirect_to "/users/mypage/mypage/#{current_user.id}"
    else
      flash[:alert] = "編集の保存に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end


  private
  def user_password_params
    params.require(:user).permit(:email, :password)
  end
end
