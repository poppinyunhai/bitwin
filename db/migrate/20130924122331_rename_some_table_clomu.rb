class RenameSomeTableClomu < ActiveRecord::Migration
  def change
  	rename_column :trades, :blank_operation_id, :blank_account_id
  	rename_column :trades, :account_operation_id, :coin_account_id
  	
  	rename_column :trade_orders, :account_operation_id, :coin_account_id
  	rename_column :trade_orders, :blank_operation_id, :blank_account_id
  end
end
