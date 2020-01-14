class UserTellsController < ApplicationController
  include SetUser
  before_action :set_user
  
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
