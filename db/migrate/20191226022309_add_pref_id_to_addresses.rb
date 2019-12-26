class AddPrefIdToAddresses < ActiveRecord::Migration[5.2]
  def change
    add_column :addresses, :pref_id, :integer
  end
end
