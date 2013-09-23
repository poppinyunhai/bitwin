class RemoveBlankCurrencyIdFromBlankOperations < ActiveRecord::Migration
  def change
    remove_column :blank_operations, :blank_currency_id, :string
  end
end
