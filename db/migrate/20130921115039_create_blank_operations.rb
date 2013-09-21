class CreateBlankOperations < ActiveRecord::Migration
  def change
    create_table :blank_operations do |t|
      t.integer :user_id, :null => false

      t.string :blank_currency_id,     :null => false
      
      t.decimal :amount,
        :precision => 16,
        :scale => 8,
        :default => 0,
        :null => false

      t.timestamps
    end

    AccountOperation.destroy_all
    BlankOperation.destroy_all

    User.all.each do |u|
      ao = AccountOperation.new
      ao.amount = 1000
      ao.user = u
      ao.currency = Currency.find_by_code('btc')
      ao.save!

      bp = BlankOperation.new
      bp.amount = 1000
      bp.user = u
      bp.blank_currency = BlankCurrency.find_by_code('cny')
      bp.save!
    end
  end
end
