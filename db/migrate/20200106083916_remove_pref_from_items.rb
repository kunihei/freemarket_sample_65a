class RemovePrefFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :pref, :integer
  end
end
