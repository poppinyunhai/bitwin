class UserCell < Cell::Rails
	def google_auth args
		render locals: args
	end

	def ips args
		render locals: args
	end
end