class UserAddressesController < ApplicationController
  include SetUser
  include UserConfirmation
  before_action :set_user
  before_action :user_confirmation
  
  # 配送先住所編集機能
  def update
    
    @address = @user.address
    if @address.update(user_address_params)
      flash[:notice] = "変更を保存しました"
      redirect_to "/users/mypage/mypage/#{current_user.id}"
    else
      flash[:alert] = "編集の保存に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def user_address_params
    params.require(:address).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_id, :city, :block, :building, :tell)
  end
end
