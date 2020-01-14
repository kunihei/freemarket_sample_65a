class AddClomunToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :transaction_text, :string
  end
end
