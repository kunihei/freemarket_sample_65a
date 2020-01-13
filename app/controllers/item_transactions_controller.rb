class ItemTransactionsController < ApplicationController
  include SetItem
  before_action :set_item
  def update
    @item.update(send_params)
    redirect_to transaction_item_path(@item.id)
  end

  private
  def send_params
    params.require(:item).permit(:send_id)
  end
end
