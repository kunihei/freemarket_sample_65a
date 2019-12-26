class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :name,null: false
      t.text :text,null: false
      t.integer :status,default: 0, null: false
      t.integer :delivery_method,default: 0, null: false
      t.integer :delivery_day,default: 0, null: false
      t.integer :pref,default: 0, null: false
      t.integer :postage_selct,default: 0, null: false
      t.integer :price,null: false
      t.integer :size,default: 0
      t.timestamps
    end
  end
end
