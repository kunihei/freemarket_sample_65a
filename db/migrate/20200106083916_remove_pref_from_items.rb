class RemovePrefFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :pref_id, :integer
  end
end
