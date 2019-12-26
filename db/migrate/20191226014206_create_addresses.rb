class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :postcode, null: false
      t.string :city, null: false
      t.string :block, null: false
      t.string :building
      t.string :tell, null: false, unique: true
      t.timestamps
    end

    add_index :addresses, :tell,                unique: true
  end
end
