task 'create_user_operations' => :environment do
	BlankAccount.destroy_all
	CoinAccount.destroy_all
	User.all.each do |user|
		Currency.all.each do |currency|
      ao = CoinAccount.new
      ao.currency = currency
      ao.user = user
      # if Rails.env.development?
      #   ao.address = "1D5CPeiFzLH29bxt3KtRrg1vDddDq7ybSr"
      # else
      #   ao.address = Bitcoin::Client.instance.getnewaddress(user.id.to_s)
      # end
      ao.address = Bitcoin::Client.instance.getnewaddress(user.id.to_s)
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