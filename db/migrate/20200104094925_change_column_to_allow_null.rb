class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :addresses, :tell,:string, null: true 
  end

  def down
    change_column :addresses, :tell,:string, null: false
  end
end
