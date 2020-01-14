class CreateTComments < ActiveRecord::Migration[5.2]
  def change
    create_table :t_comments do |t|
      t.integer :user_id
      t.integer :item_id
      t.text :text

      t.timestamps
    end
  end
end
