class CreateTradeOrders < ActiveRecord::Migration
  def change
    create_table :trade_orders do |t|
      t.integer :account_operation_id
      t.integer :user_id
      t.decimal :amount,
                :precision => 16,
                :scale => 8,
                :default => 0
      t.decimal :ppc,
                :precision => 16,
                :scale => 8,
                :default => 0
      t.string :category
      t.string :state
      t.boolean :dark_pool
      t.boolean :dark_pool_exclusive_match

      t.timestamps
    end
  end
end
