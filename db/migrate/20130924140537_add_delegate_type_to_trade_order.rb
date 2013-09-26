class AddDelegateTypeToTradeOrder < ActiveRecord::Migration
  def change
    add_column :trade_orders, :delegate_type, :string
  end
end
