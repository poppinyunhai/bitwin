class RemoveTradedCurrencyFromTrades < ActiveRecord::Migration
	def change
    remove_column :trades, :traded_currency, :decimal
  end
end