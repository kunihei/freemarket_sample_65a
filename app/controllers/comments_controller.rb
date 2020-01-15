class CommentsController < ApplicationController
  def create
    if user_signed_in?
      @comment = Comment.create(comment_params)
      respond_to do |format|
        format.html { redirect_to item_path(@comment.item.id) }
        format.json
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
