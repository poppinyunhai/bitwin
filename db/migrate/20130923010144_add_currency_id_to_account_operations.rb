class AddCurrencyIdToAccountOperations < ActiveRecord::Migration
  def change
    add_column :account_operations, :currency_id, :integer
  end
end
