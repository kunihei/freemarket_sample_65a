class ItemTransactionsController < ApplicationController
  include SetItem
  before_action :set_item
  def update
    if @item.update(send_params)
      redirect_to transaction_item_path(@item.id), data: {"turbolinks" => false}
    else 
      flash[:alert] = "情報の送信に失敗しました"
      redirect_back(fallback_location: root_path)
    end 
  end

  private
  def send_params
    params.require(:item).permit(:send_id)
  end
end
