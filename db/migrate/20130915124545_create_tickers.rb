class CreateTickers < ActiveRecord::Migration
  def change
    create_table :tickers do |t|
      t.float :last_price
      t.float :open_price
      t.float :volume
      t.float :lowest_sell
      t.float :high_buy

      t.timestamps
    end
  end
end
