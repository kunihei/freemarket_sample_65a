class AddSoldToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :sold, :integer
  end
end
