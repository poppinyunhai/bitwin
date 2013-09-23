class AddBlankCurrencyIdToBlankOperations < ActiveRecord::Migration
  def change
    add_column :blank_operations, :blank_currency_id, :integer
  end
end
