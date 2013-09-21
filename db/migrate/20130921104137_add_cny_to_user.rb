class AddCnyToUser < ActiveRecord::Migration
  def change
    add_column :users, :cny, :decimal,
        :precision => 16,
        :scale => 8,
        :default => 0,
        :null => false
  end
end
