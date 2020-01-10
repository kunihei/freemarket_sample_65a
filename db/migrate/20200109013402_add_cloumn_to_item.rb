class AddCloumnToItem < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :sub_genre, :integer,default: 0
  end
end
