class AddSendIdToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :send_id, :integer
  end
end
