class ItemsController < ApplicationController
  def index
    @items = Item.includes(:images).order('created_at DESC')
  end

  def show
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
