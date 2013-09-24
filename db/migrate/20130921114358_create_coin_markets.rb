class CreateCoinMarkets < ActiveRecord::Migration
  def change
    create_table :coin_markets do |t|
      t.integer :currency_id
      t.integer :blank_currency_id

      t.timestamps
    end

    cm = CoinMarket.new
    cm.currency = Currency.find_by_code('btc')
    cm.blank_currency = BlankCurrency.find_by_code('cny')
    cm.save!
  end
end
