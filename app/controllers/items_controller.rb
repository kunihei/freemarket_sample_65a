class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :buy_confirmation, :pay, :transaction,:transaction_update ,:evaluation_update]
  before_action :set_card, only: [:buy_confirmation, :pay]
  before_action :set_user, only: [:show, :transaction]
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

  #item作成ページ
  def new
    @item = Item.new
    @item.images.new
  end
  #item新規登録
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end
  #itme詳細
  def show
    #選択されたitemの持つ画像を全て取得
    @item_images = @item.images
    #選択されたitemのuserが持つ出品情報取得
    @user_items = Item.where(user_id: @user.id).limit(6)
    #選択されたitemが持つカテゴリー情報取得
    @genre_items = Item.where(genre: @item.genre).limit(6)
    #likeのインスタンス作成
    @like = Like.new
  end

  def edit
    gon.item = @item
    gon.images = @item.images
  end

  def update
    # 登録済画像のidの配列を生成
    ids = @item.images.map{|image| image.id }
    # 登録済画像のうち、編集後もまだ残っている画像のidの配列を生成(文字列から数値に変換)
    exist_ids = registered_image_params[:ids].map(&:to_i)
    # 登録済画像が残っていない場合(配列に０が格納されている)、配列を空にする
    exist_ids.clear if exist_ids[0] == 0

    if (exist_ids.length != 0 || new_image_params[:images][0] != " ") && @item.update(item_params)

      # 登録済画像のうち削除ボタンをおした画像を削除
      unless ids.length == exist_ids.length
        # 削除する画像のidの配列を生成
        delete_ids = ids - exist_ids
        delete_ids.each do |id|
          @item.images.find(id).destroy
        end
      end

      # 新規登録画像があればcreate
      unless new_image_params[:images][0] == " "
        new_image_params[:images].each do |image|
          @item.images.create(src: image, item_id: @item.id)
        end
      end
    end
    redirect_to item_path(@item), data: {turbolinks: false}
  end

  def destroy
    if @item.destroy
      redirect_to root_path , notice: '削除に成功しました。'
    else
      render :show, alert: '削除に失敗しました。'
    end
  end

  #購入確認画面
  def buy_confirmation
    @address = @item.user.address
    if @item.user_id != current_user.id
      if @card.present?
        Payjp.api_key =  Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
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
    else
      flash[:alert] = '出品者様は購入できません'
      redirect_to root_path
    end
  end

  #購入機能
  def pay
    if @card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    else
      Payjp.api_key =  Rails.application.credentials.payjp[:PAYJP_SECRET_KEY]
      Payjp::Charge.create(
        amount: @item.price, #支払金額
        customer: @card.customer_id, #顧客ID
        currency: 'jpy', #日本円
        )
      @item.update(buyer_id: current_user.id)
      redirect_to root_path
    end
  end

  #取引画面
  def transaction
    if @item.user_id == current_user.id || @item.buyer_id == current_user.id
      render :transaction
    else
      redirect_to root_path
    end
  end

  def transaction_update
    @item.update(send_params)
    redirect_to transaction_item_path(@item.id)
  end

  def evaluation_update
    @item.update(evaluation_params)
    redirect_to transaction_item_path(@item.id)
  end
  #キーワードで検索機能
  def search
    @keyword = params[:keyword]
    @items = Item.search(@keyword).order("created_at DESC")
    @count = @items.count
    @items = Item.all if @items.count == 0
  end

  #カテゴリーでの検索機能
  def categories
    @items = Item.where(genre: params[:id]).page(params[:page]).per(20)
    @item  = @items[0]
    @category = @item.genre
  end
  #都道府県での検索機能
  def prefectures
    @items = Item.where(prefecture_id: params[:id]).page(params[:page]).per(20)
    @item  = @items[0]
    @prefecture = @item.prefecture.name
  end



  private
  # ストロングパラメーター
  def item_params
    params.require(:item).permit(:name,:text,:status,:postage_selct,:prefecture_id,:delivery_day,:price,:genre,:size,:deliver_method,:brand, images_attributes: [:src, :_destroy, :id]).merge(user_id: current_user.id)
  end

  def registered_image_params
    params.require(:registered_images_ids).permit({ids: []})
  end

  def new_image_params
    params.require(:new_images).permit({images: []})
  end
  
  def send_params
    params.require(:item).permit(:send_id)
  end

  def evaluation_params
    params.require(:item).permit(:evaluation ,:sold)
  end

  # before_action
  def set_item
    @item = Item.find(params[:id])
  end

  def set_card
    @card = Card.find_by(user_id: current_user.id) if Card.where(user_id: current_user.id).present?
  end
  
  def set_user
    @user = @item.user
  end
end
