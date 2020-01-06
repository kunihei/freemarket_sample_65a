class AddSizeToItems < ActiveRecord::Migration[5.2]
  def changeu
    add_column :items, :deliver_method, :integer
    add_column :items, :brand, :integer
  end
end
