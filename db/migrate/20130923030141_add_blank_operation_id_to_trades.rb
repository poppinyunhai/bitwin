class AddBlankOperationIdToTrades < ActiveRecord::Migration
  def change
    add_column :trades, :blank_operation_id, :integer
  end
end