class AddLockToOprations < ActiveRecord::Migration
  def change
  	add_column :account_operations, :blocked, 
  	    :decimal,
        :precision => 16,
        :scale => 8,
        :default => 0,
        :null => false

    add_column :blank_operations, :blocked, 
  	    :decimal,
        :precision => 16,
        :scale => 8,
        :default => 0,
        :null => false
  end
end
