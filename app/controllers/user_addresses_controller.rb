class UserAddressesController < ApplicationController
  include SetUser
  before_action :set_user
  
  def update
    @address = @user.address
    @address.update(user_address_params)
    redirect_to root_path
  end


  private
  def user_address_params
    params.require(:address).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_id, :city, :block, :building, :tell)
  end
end
