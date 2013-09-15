class AddTradeHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :trade_hash, :string
  end
end
