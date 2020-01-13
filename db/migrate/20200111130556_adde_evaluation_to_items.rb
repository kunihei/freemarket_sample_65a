class AddeEvaluationToItems < ActiveRecord::Migration[5.2]
  def change
    add_column :items, :evaluation, :integer
  end
end
