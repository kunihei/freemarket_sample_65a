class RemoveSubgenreFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :subgenre, :integer
  end
end
