class TCommentsController < ApplicationController
  def create
    if comment = TComment.create(comment_params)
      redirect_back(fallback_location: root_path)
    else
      flash[:alert] = "コメントの送信に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def comment_params
    params.require(:t_comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
