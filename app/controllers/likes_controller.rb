class LikesController < ApplicationController
  include SetItem
  include UserSignedIn
  before_action :user_signed_in?
  before_action :set_item
  before_action :not_user_like

  def create
    @item.increment!(:likes_count, 1)
    @like = Like.create(user_id: current_user.id, item_id: params[:item_id])
    @likes = Like.where(item_id: params[:item_id])
  end


  def destroy
    @item.decrement!(:likes_count, 1)
    @like = Like.find_by(user_id: current_user.id, item_id: params[:item_id])
    @like.destroy
    @likes = Like.where(item_id: params[:item_id])
  end

  private
  def  not_user_like
    if @item.user_id == current_user.id
      flash[:alert] = "出品者は良いねできません"
      redirect_to root_path
    end
  end
end
