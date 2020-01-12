class AddeAddresToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postcode, :string
    add_column :users, :prefecture_id, :integer
    add_column :users, :city, :string
    add_column :users, :block, :string
    add_column :users, :building, :string
  end
end
