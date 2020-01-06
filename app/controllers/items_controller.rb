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
    @item = Item.find_by(param)
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
    Item.create(item_params)
  end

  private
    def item_params
      params.require(:item).permit(:name,:text,:status,:postage_selct,:pref,:delivery_day,:price, images_attributes: [:src])
      @category = Category.new
    end
end
