class UserIdentificationsController < ApplicationController

  before_action :set_user

  def update
    @user.update(user_identification_params)
    redirect_to root_path
  end


  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_identification_params
    params.require(:user).permit(:postcode, :prefecture_id, :city, :block, :buildin)
  end
end
