class UserPassController < ApplicationController
  include SetUser
  include UserConfirmation
  include UserSignedIn
  before_action :user_signed_in?
  before_action :set_user
  before_action :user_confirmation

  
  #パスワード/メールアドレスの編集機能
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
