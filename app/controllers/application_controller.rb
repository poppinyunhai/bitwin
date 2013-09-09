class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_filter :authenticate_user! 
  before_filter :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  # before_filter :google_auth

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  protected

  def configure_permitted_parameters
  	devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
	end

  def google_auth
    # if current_user and current_user.google_secret
    #   unless session[:google_auth]
    #     redirect_to new_user_mfa_session_path
    #   end
    # end
  end
end
