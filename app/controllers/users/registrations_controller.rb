# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  before_action :configure_sign_up_params, only: [:create]

  require 'payjp'


  #1本人情報登録
  def new 
    @user = User.new  #インスタンス作成
  end

  #本人情報(post)
  def create
    @user = User.new(sign_up_params)  #データの代入
    unless @user.valid? #バリデーション 
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @number = @user.build_number  #インスタンス作成
    render :new_tellphone
  end

  #2電話番号確認(post)
  def create_tellphone
    @user   = User.new(session["devise.regist_data"]["user"])
    @number = Number.new(user_params) #データの代入
    unless @number.valid? #バリデーション 
      flash.now[:alert] = @number.errors.full_messages
      render :new_tellphone and return
    end
    session["devise.regist_data2"] = {number: @number.attributes}  #セッションの作成
    @user.build_number(@number.attributes)
    @address = @user.build_address  #インスタンス作成
    render :new_address
  end
  
  #3お届け先住所(post)
  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid? #バリデーション 
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    session["devise.regist_data3"] = {address: @address.attributes}   #セッションの作成
    @card = Card.new  #インスタンス作成
    render :new_cards
  end

  #4お支払い方法
  def create_cards
    Payjp.api_key =  Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
    @user = User.new(session["devise.regist_data"]["user"])
    if params['payjp-token'].blank?
      redirect_to root_path
    else
      customer = Payjp::Customer.create( # ここで先ほど生成したトークンを顧客情報と紐付け、PAY.JP管理サイトに送信
        email: @user.email,
        card: params['payjp-token'],
        metadata: {user: @user}
      )
      @card = Card.new(user: @user, customer_id: customer.id, card_id: customer.default_card)
      #ユーザー情報の作成
      @number = Number.new(session["devise.regist_data2"]["number"])
      @address = Address.new(session["devise.regist_data3"]["address"])
      @user.build_address(@address.attributes)
      @user.build_number(@number.attributes)
      if @card.save && @user.save  #ユーザー情報のsaveとカード情報のsave
        sign_in(:user, @user)
        render :new_finish
      else
        redirect_to root_path
      end

    end
  end
  
  #5完了ページ
  def new_finish
    
  end

  
  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end    
  def user_params
    params.require(:number).permit(:tell)
  end
  def address_params
    params.require(:address).permit(:postcode,:prefecture_id, :city, :block, :building, :tell, :last_name, :first_name, :last_name_kana, :first_name_kana)
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  
end
