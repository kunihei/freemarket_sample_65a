class AddTellToNumber < ActiveRecord::Migration[5.2]
  def change
    add_column :numbers, :tell, :string
  end
end
