class RemovePrefFromAddresses < ActiveRecord::Migration[5.2]
  def change
    remove_column :addresses, :pref_id, :integer
  end
end
