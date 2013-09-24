class CreateBlankOperations < ActiveRecord::Migration
  def change
    create_table :blank_operations do |t|
      t.integer :user_id, :null => false

      t.string :blank_currency_id,     :null => false
      
      t.decimal :amount,
        :precision => 16,
        :scale => 8,
        :default => 0,
        :null => false

      t.timestamps
    end
  end
end
