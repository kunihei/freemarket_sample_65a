class AddDefaltToItems < ActiveRecord::Migration[5.2]
  def change
    change_column_default :items,:genre,default: 0
    change_column_default :items,:deliver_method,default: 0
    change_column_default :items,:brand,default: 0
  end
end
