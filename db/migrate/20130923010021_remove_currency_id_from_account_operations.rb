class RemoveCurrencyIdFromAccountOperations < ActiveRecord::Migration
  def change
    remove_column :account_operations, :currency_id, :string
  end
end
