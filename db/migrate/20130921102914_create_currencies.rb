class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :code

      t.timestamps
    end

    %w{btc ltc}.each do |c|
    	cu = Currency.new
    	cu.code = c
    	cu.save!
    end
  end
end
