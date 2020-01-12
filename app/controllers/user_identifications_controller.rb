class UserIdentificationsController < ApplicationController
  include SetUser
  before_action :set_user

  def update
    @user.update(user_identification_params)
    redirect_to root_path
  end


  private

  def user_identification_params
    params.require(:user).permit(:postcode, :prefecture_id, :city, :block, :buildin)
  end
end
