class UserIdentificationsController < ApplicationController
  include SetUser
  include UserConfirmation
  include UserSignedIn
  before_action :user_signed_in?
  before_action :set_user
  before_action :user_confirmation

  #本人情報編集機能
  def update
    if @user.update(user_identification_params)
      flash[:notice] = "変更を保存しました"
      redirect_to "/users/mypage/mypage/#{current_user.id}"
    else
      flash[:alert] = "編集の保存に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def user_identification_params
    params.require(:user).permit(:postcode, :prefecture_id, :city, :block, :buildin)
  end
end
