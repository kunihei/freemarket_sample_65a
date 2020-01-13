class UserTellsController < ApplicationController
  include SetUser
  before_action :set_user
  
  def update
    if  @number = @user.number
      @number.update(user_tell_params)
      redirect_to "/users/mypage/mypage/#{current_user.id}"
    else
      redirect_to root_path, alert: '情報更新に失敗しました。'
    end
  end


  private

  def user_tell_params
    params.require(:number).permit(:tell)
  end
end
