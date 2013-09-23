class RenameSomeTable < ActiveRecord::Migration
  def change
  	rename_table :account_operations, :coin_accounts
  	rename_table :blank_operations,  :blank_accounts
  end
end
