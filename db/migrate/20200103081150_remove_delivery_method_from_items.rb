class RemoveDeliveryMethodFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :delivery_method, :integer
  end
end
