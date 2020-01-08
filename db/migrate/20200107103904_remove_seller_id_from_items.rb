class RemoveSellerIdFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :seller_id, :integer
  end
end
