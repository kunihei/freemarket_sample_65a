class UsersController < ApplicationController
  before_action :set_number, only: [:tell_update]
  before_action :set_address, only: [:address_update]
  
  include SetUser 
  before_action :set_user, except: [:new]
  before_action :Guard_clause, only: [:update, :mypage, :item_exhibit, :item_negotiate, :item_buyed]
  
  def show
    @user = User.find(current_user.id) 
  end

  
  def edit
    @number = @user.number
    @address = @user.address
    if @user.id == current_user.id
      render "users/edit/#{params[:name]}" 
    else
      flash[:alert]= 'ユーザーが違います'
      redirect_to root_path
    end
  end

  # プロフィール更新
  def update
    @user.update(user_params)
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

  def show
    @user = User.find(params[:id])
  end
  
  def mypage
    
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :introduction,:avatar_image)
  end

  def Guard_clause
    if @user.id == current_user.id
      render "users/mypage/#{params[:name]}"
    else
      flash[:alert]= 'ユーザーが違います'
      redirect_to root_path
    end
  end

end
