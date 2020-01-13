class UsersController < ApplicationController
  before_action :set_number, only: [:edit, :tell_update]
  before_action :set_address, only: [:edit, :address_update]
  include SetUser 
  before_action :set_user, except: [:new]
  
  def show
    @user = User.find(current_user.id) 
  end

  
  def edit
    @number = @user.number
    @address = @user.address
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


  def item_exhibit
    @user = User.find(current_user.id)
  end

  def item_negotiate
    @user = User.find(current_user.id)
  end
  


  def item_buyed
    @user = User.find(current_user.id)
  end

  def personal_details
    @user = User.find(params[:id])
  end
  
  def mypage
    if @user.id == current_user.id
      render "users/mypage/#{params[:name]}" 
    else
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :introduction)
  end

end
