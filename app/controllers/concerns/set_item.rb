module SetItem
  extend ActiveSupport::Concern

  private
  def set_item
    @item = Item.find(params[:id])
  end
end