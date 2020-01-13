class ItemEvaluationsController < ApplicationController
  include SetItem
  before_action :set_item
  def update
    @item.update(evaluation_params)
    redirect_to transaction_item_path(@item.id)
  end

  private
  def evaluation_params
    params.require(:item).permit(:evaluation ,:sold)
  end
end
