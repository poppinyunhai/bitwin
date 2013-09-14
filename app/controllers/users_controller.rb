#encoding : utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:sigined_up, :found_password_check]
  layout false, only: [:sms_bind,:solutions_sms_bind]

  def account
    
  end

  def deals
    
  end

  def info_edit
  end


  def info_update
  	Attachment.create(:attachmentable => current_user, :attachment => params[:attachment]) if params[:attachment]
  	redirect_to root_path
  end

  def close_google_auth
    current_user.google_secret = nil
    if current_user.save!
      flash[:notice] = "恭喜你，解绑google认证"
    else
      flash[:notice] = "很遗憾！解绑google认证失败"
    end
    redirect_to user_account_path
  end

  def google_auth
    current_user.set_google_secret
    redirect_to user_account_path, notice: "恭喜你，google绑定成功"
  end

  def real_name_authentication
  	if current_user.real_name.nil?
  		current_user.real_name = params[:real_name].strip
  		current_user.save!
  		redirect_to root_path, :notice => "恭喜你，成功完成实名绑定!"
  	else
  		redirect_to root_path, :error => "实名一经绑定，不能再次绑定!"
  	end
  end

  def seed_sms_code
    session[:mobile] = params[:user][:mobile] unless params[:user].to_s.empty?
    @seed_state = Authentication::SmsAuth.new(mobile: current_user.mobile||params[:user][:mobile]||session[:mobile], email: current_user.email)
  end

  def sms_bind
    if Authentication::SmsAuth.validate(email: current_user.email, code: params[:user][:code])
      current_user.mobile = session[:mobile]
      @result_state = current_user.save!
      @info = "绑定成功！"
    else
      @error = "验证码有误, 绑定失败, 请重试!"
    end
  end

  def solutions_sms_bind
    if Authentication::SmsAuth.validate(email: current_user.email, code: params[:user][:code])
      current_user.mobile = nil
      current_user.save!
      @info = "解除绑定成功！"
    else
      @error = "验证码有误, 解除绑定失败, 请重试!"
    end
  end

  def found_password_check
    type = params[:type]
    value = params[:value]
      # do_check  
      # case type
      # when 'email'

      # when 'phone'
      # when 'quetion'
      # end
    redirect_to edit_user_password_path(:reset_password_token=>'there is a token')
   end
end
