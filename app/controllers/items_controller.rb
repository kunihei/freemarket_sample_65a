class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :destroy]

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

  def new
    @item = Item.new
    @item.images.new
  end

  def update
  end

  def destroy
    
    if @item.destroy
      redirect_to root_path
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path , notice: '削除に成功しました。'
    else
      render :show, alert: '削除に失敗しました。'
    end
  end

  private

  def set_item
   #選択されたitemの取得
   @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name,:text,:status,:postage_selct,:prefecture_id,:delivery_day,:price,:genre,:size,:deliver_method,:brand, images_attributes: [:src]).merge(user_id: current_user.id)
  end


end
