

## users テーブル
|Column|Type|Options|
|------|----|-------|
|avatar_image   |text   |                                   <!-- アイコン -->
|introduction   |text   |                                   <!-- 自己紹介文 -->
|nickname       |string |null: false|                       <!-- ニックネーム -->
|email          |string |null: false, add_index, unique :true|<!-- メアド -->
|password       |string |null: false|                       <!-- パス --> 
|last_name      |string |null: false|                       <!-- 苗字 -->
|first_name     |string |null: false|                       <!-- 名前 -->
|last_name_kana |string |null: false|                       <!-- 苗字（カナ） -->
|first_name_kana|string |null: false|                       <!-- 名前(カナ) -->
|birthday       |date   |null: false|                       <!-- 誕生日 --> 
### Association
has_many :likes
has_many :addresses
has_many :commnets
has_many :items
has_many :reviews





## addresses テーブル
|Column|Type|Options|
|------|----|-------|
|postcode |string |null: false|                              <!-- 郵便番号 -->
|city     |string |null: false|                              <!-- 市町村 -->
|block    |string |null: false|                              <!-- 番地 -->
|building |string |                                          <!-- 建物名 任意-->
|tell     |string |null: false, add_index, unique :true|     <!-- 電話番号 -->
|user_id  |integer|null: false, foreign_key: true|           <!-- 外部キー-->
### Association
belongt_to :user


## items テーブル
|Column|Type|Options|
|------|----|-------|
|name           |string |null: fals|
|text           |text   |null: fals|              <!-- 商品説明欄-->
|status         |integer|default: 0, null: false| <!-- 商品状態 enum-->
|delivery_method|integer|default: 0, null: false| <!-- 配送方法 enum-->
|delivery_day   |integer|default: 0, null: false| <!-- 配送までの日数 enum-->
|pref           |integer|default: 0, null: false| <!-- 発送地域--> 
|postage_selct  |integer|default: 0, null: false| <!-- 送料負担-->
|price          |integer|null: false|              <!-- 価格-->
|size           |integer|default: 0|              <!-- サイズ enum-->
|user_id        |null: false, foreign_key: true|
|brand_id       |null: false, foreign_key: true|
### Association
has_many :likes
has_many :comments
has_many :photos
has_many :items_catgoriess
has_many :category through: :items_catgories
belongs_to :brand
belongs_to :user


## categories テーブル
|Column|Type|Options|
|------|----|-------|
|genre   |integer|default: 0,null false|<!-- カテゴリ大-->
|subgenre|integer|default: 0,null false|<!-- カテゴリ中-->
|detail  |integer|default: 0,null false|<!-- カテゴリ小-->
### Association
has_many :items_catgories
has_many :items through: :items_catgoriess



## items_categories テーブル（中間テーブル）
|Column|Type|Options|
|------|----|-------|
|item_id    |null: false, foreign_key: true|<!-- 外部キー-->
|category_id|null: false, foreign_key: true|<!-- 外部キー-->
### Association
belongs_to :item
belongs_to :category


## photo テーブル
|Column|Type|Options|
|------|----|-------|
|url    |text   |null: false|<!-- 最低一枚必須？--><!-- 商品写真-->
|item_id|integer|null: false,foreign_key: true|
### Association
belongs_to :item


##  brand テーブル
|Column|Type|Options|
|------|----|-------|
|name  |strung|           <!-- カテゴリー選択後必要なら--><!-- ブランド名-->
### Association
hasmany :items



## likes
|Column|Type|Options|
|------|----|-------|              
|item_id|integer|null false,foreign_key: true|<!-- 外部キー -->
|user_id|integer|null false,foreign_key: true|<!-- 外部キー -->
### Association
belongs_to :item
belongs_to :user

## comment
|Column|Type|Options|
|------|----|-------|
|messge |text   |null: false|<!-- コメント-->
|item_id|integer|null false,foreign_key: true|<!-- item外部キー -->
|user_id|integer|null false,foreign_key: true|<!-- user外部キー -->
### Association
belongs_to :user
belongs_to :item

## review
|Column|Type|Options|
|------|----|-------|
|evaluation |integer|null: false|<!-- 評価    enum-->
|message    |text   |null: false|<!-- 評価文  enum-->
|user_id    |integer|null false,foreign_key: true|<!-- user外部キー -->
### Association
belongs_to :user






class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]

  def new 
    @user = User.new
  end

  def create
    @user = User.new(sign_up_params)
    unless @user.valid?
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes}
    session["devise.regist_data"][:user]["password"] = params[:user][:password]
    @number = PhoneNumber.new
    render :new_tellphone
  end


  def create_tellphone
    @number = PhoneNumber.new(user_params)
    session["devise.regist_data2"] = {phoneNumber: @number.attributes}
    @user = User.new(session["devise.regist_data"]["user"])
    @address = @user.build_address
    render :new_address
  end
  

  def create_address
    @user = User.new(session["devise.regist_data"]["user"])
    @address = Address.new(address_params)
    unless @address.valid?
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end
    @user.build_address(@address.attributes)
    @user.save
    render :new_payment
  end

  
  def create_payment
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