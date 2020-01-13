class UserIdentificationsController < ApplicationController
  include SetUser
  before_action :set_user

  def update
    if @user.update(user_identification_params)
      redirect_to "/users/mypage/mypage/#{current_user.id}"
    else
      redirect_to root_path, alert: '情報更新に失敗しました。'
    end
  end


  private

  def user_identification_params
    params.require(:user).permit(:postcode, :prefecture_id, :city, :block, :buildin)
  end
end
