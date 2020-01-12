class UserTellsController < ApplicationController
  include SetUser
  before_action :set_user
  
  def update
    @number = @user.number
    @number.update(user_tell_params)
    redirect_to root_path
  end


  private

  def user_tell_params
    params.require(:number).permit(:tell)
  end
end
