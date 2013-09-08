class UserMfaSessionController < ActionController::Base

	before_filter :authenticate_user!

	layout 'application'

	def new
		redirect_to root_path if session[:google_auth]
	end

	def authentic
		if current_user.google_authentic?(params[:code])
			session[:google_auth] = true
			redirect_to root_path
		else
			render :new
		end
	end
end