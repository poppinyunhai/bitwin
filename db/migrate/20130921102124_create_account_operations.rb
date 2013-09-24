class CreateAccountOperations < ActiveRecord::Migration
  def change
    create_table :account_operations do |t|

      t.integer :user_id,    :null => false
      t.string :currency_id,     :null => false
      
      t.decimal :amount,
        :precision => 16,
        :scale => 8,
        :default => 0,
        :null => false

      t.string :address

      t.timestamps
    end
  end
end
