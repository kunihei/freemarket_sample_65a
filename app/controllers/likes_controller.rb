class LikesController < ApplicationController
  def create
    @item = Item.find(params[:item_id])
    @like = Like.create(user_id: current_user.id, item_id: params[:item_id])
    @likes = Like.where(item_id: params[:item_id])
  end


  def destroy
    @item = Item.find(params[:id])
    @like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
    @like.destroy
    @likes = Like.where(item_id: params[:item_id])
  end

  def get_item
    @item = Product.find(params[:item_id])
  end
end
