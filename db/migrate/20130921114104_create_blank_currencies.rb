class CreateBlankCurrencies < ActiveRecord::Migration
  def change
    create_table :blank_currencies do |t|
      t.string :code

      t.timestamps
    end

    %w{cny usd}.each do |c|
    	cu = BlankCurrency.new
    	cu.code = c
    	cu.save!
    end
  end
end
