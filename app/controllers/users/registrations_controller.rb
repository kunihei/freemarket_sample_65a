# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new 
    @user = User.new                          #インスタンス作成
  end

  def create                                  #(ユーザー情報)
    @user = User.new(sign_up_params)          #データの代入(ユーザー情報)
    unless @user.valid?                       #バリデーション
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @number = @user.build_phone_number        #インスタンス作成
    render :new_tellphone
  end


  def create_tellphone                                     #(電話番号)
    @number = PhoneNumber.new(user_params)                 #データの代入(電話番号)
    session["devise.regist_data2"] = {phoneNumber: @number.attributes}#セッションの作成
    @user = User.new(session["devise.regist_data"]["user"])
    @address = @user.build_address                         #インスタンス作成
    render :new_address
  end
  

  def create_address   #(お届け先住所)
    @user = User.new(session["devise.regist_data"]["user"])#セッションの代入(ユーザー情報)
    @number = PhoneNumber.new(number: session["devise.regist_data2"])
    @address = Address.new(address_params)                 #データの代入(お届け先住所)
    unless @address.valid?                                 #バリデーション
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    render :new_cards
  end

  def new_cards
  end

  
  def create_cards
    render :new_finish
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
