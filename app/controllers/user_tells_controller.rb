class UserTellsController < ApplicationController
  include SetUser
  include UserConfirmation
  before_action :set_user
  before_action :user_confirmation
  

  #電話番号の編集機能
  def update
    if  @number = @user.number
      @number.update(user_tell_params)
      flash[:notice] = "変更を保存しました"
      redirect_to "/users/mypage/mypage/#{current_user.id}"
    else
      flash[:alert] = "編集の保存に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def user_tell_params
    params.require(:number).permit(:tell)
  end
end
