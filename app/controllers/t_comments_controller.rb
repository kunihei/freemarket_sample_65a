class TCommentsController < ApplicationController
  include UserSignedIn
  before_action :user_signed_in
  def create
    if @item.user_id == current_user.id || @item.buyer_id == current_user.id
      @comment = TComment.create(comment_params)
      respond_to do |format|
        format.html { redirect_to transaction_item_path(@comment.item.id) }
        format.json
      end
    else
      flash[:alert] = "該当ユーザーではありません"
      redirect_to root_path
    end
  end

  private
  def comment_params
    params.require(:t_comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
