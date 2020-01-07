class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC').limit(10)

    # @items_women = Item.Where(:genre, '').limit(10)
    # @items_men = Item.Where(:genre, '').limit(10)
    # @items_appliances = Item.Where(:genre, '').limit(10)
    # @items_hobby = Item.Where(:genre, '').limit(10)
    
    # カテゴリーに関するインスタンスの作成
    # @items.each do |item|
    #   if item.genre == 1
    #     @items_women.push(item)
    #   elsif item.genre == 2
    #     @items_men.push(item)
    #   elsif item.genre == 3
    #     @items_appliances.push(item)
    #   elsif item.genre == 4
    #     @items_hobby.push(item)
    #   end
  # end

  #   #ブランドに関するインスタンスの作成
  #   # @items.each do |item|
  #   # end

  #   @items_chanel =Item.where()
  #   @items_supreme =Item.where()
  #   @items_nike =Item.where()

  end

  def show
    #選択されたitemの取得
    @item = Item.find(params[:id])
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

  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name,:text,:status,:postage_selct,:prefecture_id,:delivery_day,:price,:genre,:size,:deliver_method,:brand, images_attributes: [:src]).merge(user_id: current_user.id)
  end


end
