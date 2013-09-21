class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :code

      t.timestamps
    end

    %w{eur lrusd lreur pgau btc usd cad inr}.each do |c|
    	cu = Currency.new
    	cu.code = c
    	cu.save!
    end

    User.all.each do |u|
      ao = AccountOperation.new
      ao.amount = 0
      ao.user = u
      ao.currency = Currency.find_by_code('btc')
      ao.save!
    end
  end
end
