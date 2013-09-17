class UserCell < Cell::Rails
	def google_auth args
		unless args[:user].google_auth
	    args[:user].set_google_secret 
	    args[:user].save!
	  end
		render locals: args
	end

	def ips args
		ips = LoginHistory.where(user: args[:user]).order('id DESC').limit(10)
		render locals: args.merge(ips: ips)
	end

	def sms args
		render locals: args
	end
end