class UserCell < Cell::Rails
	def google_auth args
		render locals: args
	end

	def ips args
		ips = LoginHistory.where(user: args[:user]).paginate(:page => params[:page]).order('id DESC')
		render locals: args.merge(ips: ips)
	end
end