class ItemEvaluationsController < ApplicationController
  include SetItem
  before_action :set_item
  def update
    if @item.update(evaluation_params)
      redirect_to transaction_item_path(@item.id), data: {"turbolinks" => false} 
    else
      flash[:alert] = "情報の送信に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  private
  def evaluation_params
    params.require(:item).permit(:evaluation ,:sold)
  end
end
