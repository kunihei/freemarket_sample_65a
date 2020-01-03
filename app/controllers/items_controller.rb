class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
    @item = Item.new
    @category = Category.new
  end

  def create
    Item.create(item_params)
  end

  private
    def item_params
      params.require(:item).permit(:name,:text,:status,:postage_selct,:pref,:delivery_day,:price)
    end
end
