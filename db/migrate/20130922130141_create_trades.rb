class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :account_operation_id
      t.integer :purchase_order_id
      t.integer :sale_order_id
      t.integer :seller_id
      t.integer :buyer_id
      t.decimal :ppc,
                :precision => 16,
                :scale => 8,
                :default => 0
      t.decimal :traded_btc,
                :precision => 16,
                :scale => 8,
                :default => 0
      t.decimal :traded_currency,
                :precision => 16,
                :scale => 8,
                :default => 0

      t.timestamps
    end
  end
end
