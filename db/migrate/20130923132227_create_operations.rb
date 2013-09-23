class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.integer :user_id
      t.integer :category
      t.decimal :amount,
        :precision => 16,
        :scale => 8,
        :default => 0,
        :null => false

      t.integer :confirmations
      t.string :blockhash
      t.datetime :blocktime
      t.datetime :timereceived
      t.string :txid
      t.string :type
      t.integer :status

      t.timestamps
    end
  end
end
