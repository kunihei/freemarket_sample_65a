# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  #1本人情報登録
  def new 
    #インスタンス作成
    @user = User.new
  end

  #本人情報(post)
  def create                                  #(ユーザー情報)
    @user = User.new(sign_up_params)          #データの代入(ユーザー情報)
    #バリデーション
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    #インスタンス作成
    @number = @user.build_phone_number        
    render :new_tellphone
  end

  #2電話番号確認(post)
  def create_tellphone                                                
    @number = PhoneNumber.new(user_params)                            #データの代入(電話番号)
    #セッションの作成
    session["devise.regist_data2"] = {phoneNumber: @number.attributes}
    @user = User.new(session["devise.regist_data"]["user"])
    @address = @user.build_address           
    #インスタンス作成
    render :new_address
  end
  

  #3お届け先住所(post)
  def create_address
    @address = Address.new(address_params)                            #データの代入(お届け先住所)
    #バリデーション
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    #セッションの作成
    session["devise.regist_data3"] = {address: @address.attributes}
    @card = @user.build_address
    render :new_cards
  end

  def new_cards

  end

  #4お支払い方法
  def create_cards
    Payjp.api_key = "sk_test_f67be4ad1051de6822903d38"
    if params['payjp-token'].blank?
      render 'mypages/create_card'
    else
      customer = Payjp::Customer.create( # ここで先ほど生成したトークンを顧客情報と紐付け、PAY.JP管理サイトに送信
        email: current_user.email,
        card: params['payjp-token'],
        metadata: {user_id: current_user.id} # 記述しなくても大丈夫です
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      session["devise.regist_data4"] = {card: @card.attributes}
    end
    render :new_finish
  end

  #5完了ページ
  def create_finish
    @user     = User.new(session["devise.regist_data"]["user"])        #1セッションの代入(ユーザー情報)
    @number   = PhoneNumber.new(number: session["devise.regist_data2"])#2セッションの代入(電話番号)
    @@address = Address.new(number: session["devise.regist_data3"])    #3セッションの代入(お届け先住所)
    @card     = Card.new(card: session["devise.regist_data4"])         #4セッションの代入(お支払い情報)
  end


  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  end    

  def user_params
    params.require(:phone_number).permit(:number)
  end

  def address_params
    params.require(:address).permit(:postcode, :city, :block, :building, :tell)
  end

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
