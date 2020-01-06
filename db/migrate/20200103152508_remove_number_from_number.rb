class RemoveNumberFromNumber < ActiveRecord::Migration[5.2]
  def change
    remove_column :numbers, :number, :string
  end
end
