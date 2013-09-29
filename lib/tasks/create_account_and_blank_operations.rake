task 'create_accounts' => :environment do

  BlankAccount.destroy_all
	CoinAccount.destroy_all
	
  User.all.each do |user|
		Currency.all.each do |currency|
      ao = CoinAccount.new
      ao.currency = currency
      ao.user = user
      if Rails.env.development?
        ao.address = "1D5CPeiFzLH29bxt3KtRrg1vDddDq7ybSr"
      else
        ao.address = Bitcoin::Client.instance.getnewaddress(currency.code+user.id.to_s)
      end
      ao.save!
    end

    BlankCurrency.all.each do |bc|
      bo = BlankAccount.new
      bo.user = user
      bo.blank_currency = bc
      bo.save!
    end
	end
end


task 'create_currency' => :environment do

  Currency.destroy_all
  BlankCurrency.destroy_all
  %w{btc ltc}.each do |c|
    cu = Currency.new
    cu.code = c
    cu.save!
  end


  %w{cny usd}.each do |c|
    cu = BlankCurrency.new
    cu.code = c
    cu.save!
  end
end


