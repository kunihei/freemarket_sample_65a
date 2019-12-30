class AddTellToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :tell, :string
  end
end
