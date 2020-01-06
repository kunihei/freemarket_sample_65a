class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def edit
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:name,:text,:status,:postage_selct,:pref,:delivery_day,:price,:genre,:size,:deliver_method,:brand).merge(user_id: current_user.id)
  end

end
