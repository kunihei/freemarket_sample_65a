class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy, :buy_confirmation, :pay]
  before_action :set_card, only: [:buy_confirmation, :pay]
  require 'payjp'

  def index
    #レディースに関するインスタンス
    @items_women = Item.where(genre: '1').order('created_at DESC').limit(10)
    #メンズに関するインスタンス
    @items_men = Item.where(genre: '2').order('created_at DESC').limit(10)
    #家電に関するインスタンス
    @items_appliances = Item.where(genre: '8').order('created_at DESC').limit(10)
    #ホビーに関するインスタンス
    @items_hobby = Item.where(genre: '6').order('created_at DESC').limit(10)
    
    #ブランドに関するインスタンスの作成
    @items_chanel =Item.where(brand: '1').order('created_at DESC').limit(10)
    #ルイヴィトンに関するインスタンス
    @items_vuitton =Item.where(brand: '3').order('created_at DESC').limit(10)
    #シュプリームに関するインスタンス
    @items_supreme =Item.where(brand: '4').order('created_at DESC').limit(10)
    #ナイキに関するインスタンス
    @items_nike =Item.where(brand: '2').order('created_at DESC').limit(10)
  end

  def new
    @item = Item.new
    @item.images.new
  end
  
  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    #選択されたitemの持つ画像を全て取得
    @item_images = @item.images
    #選択されたitemのuser情報取得
    @user = @item.user
    #選択されたitemのuserが持つ出品情報取得
    @user_items = Item.where(user_id: @user.id).limit(6)
    #選択されたitemが持つカテゴリー情報取得
    @genre_items = Item.where(genre: @item.genre).limit(6)
  end

  def edit
  end

  def update
  end

  def destroy
    if @item.destroy
      redirect_to root_path , notice: '削除に成功しました。'
    else
      render :show, alert: '削除に失敗しました。'
    end
  end

  def categories
    @items = Item.where(genre: params[:id]).page(params[:page]).per(2)
    if @items.present?
      @item = @items[0]
      @category = @item.genre
    else
      redirect_to root_path
    end
  end

  def buy_confirmation
    @address = @item.user.address
    if @card.present?
      Payjp.api_key =  ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)

      @card_brand = @card_information.brand      
      case @card_brand
      when "Visa"
        @card_src = "visa.png"
      when "JCB"
        @card_src = "jcb.png"
      when "MasterCard"
        @card_src = "master-card.png"
      when "American Express"
        @card_src = "american_express.png"
      when "Diners Club"
        @card_src = "dinersclub.png"
      when "Discover"
        @card_src = "discover.png"
      end
    end
  end

  def pay
    if @card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      Payjp::Charge.create(
        amount: @item.price, #支払金額
        customer: @card.customer_id, #顧客ID
        currency: 'jpy', #日本円
        )
      redirect_to root_path
    end
  end

  

  private

  def set_item
   #選択されたitemの取得
   @item = Item.find(params[:id])
  end

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end

  def item_params
    params.require(:item).permit(:name,:text,:status,:postage_selct,:prefecture_id,:delivery_day,:price,:genre,:size,:deliver_method,:brand, images_attributes: [:src]).merge(user_id: current_user.id)
  end


end
