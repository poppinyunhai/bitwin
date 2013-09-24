class AddBlankOperationIdToTradeOrders < ActiveRecord::Migration
  def change
    add_column :trade_orders, :blank_operation_id, :integer
  end
end