class UserTellsController < ApplicationController
  before_action :set_user
  
  def update
    @number = @user.number
    @number.update(user_tell_params)
    redirect_to root_path
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_tell_params
    params.require(:number).permit(:tell)
  end
end
