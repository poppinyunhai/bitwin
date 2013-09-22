task 'create_user_operations' => :environment do
	AccountOperation.destroy_all
	BlankOperation.destroy_all
	User.all.each do |user|
		Currency.all.each do |currency|
      ao = AccountOperation.new
      ao.currency = currency
      ao.user = user
      ao.address = Bitcoin::Client.instance.getnewaddress
      ao.save!
    end

    BlankCurrency.all.each do |bc|
      bo = BlankOperation.new
      bo.user = user
      bo.blank_currency = bc
      bo.save!
    end
	end
end