class UsersController < ApplicationController
  before_action :set_user
  before_action :set_number, only: [:edit, :tell_update]
  before_action :set_address, only: [:edit, :address_update]
  
  def show
  end

  # 各編集ページ
  def edit
    if @user.id == current_user.id
      render "users/edit/#{params[:name]}" 
    else
      redirect_to root_path
    end
  end

  # プロフィール更新
  def update
     @user.update(user_params)
     redirect_to root_path
  end
  # パスワード/メールアドレス更新
  def password_update
    @user.update(user_password_params)
    sign_in(@user, bypass: true) 
    redirect_to root_path
  end
  # 電話番号更新
  def tell_update
    @number.update(user_tell_params)
    redirect_to root_path
  end

  def item_exhibit
  end

  def item_negotiate
  end

  def item_buyed
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :introduction)
  end

  def user_address_params
    params.require(:address).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postcode, :prefecture_id, :city, :block, :building, :tell)
  end

  def user_identification_params
    params.require(:user).permit(:postcode, :prefecture_id, :city, :block, :buildin)
  end

  def user_password_params
    params.require(:user).permit(:email, :password)
  end

  def user_tell_params
    params.require(:number).permit(:tell)
  end
  # before_action
  def set_user
    @user = User.find(params[:id])
  end

  def set_number
    @number = @user.number
  end

  def set_address
    @address = @user.address
  end
    
end
