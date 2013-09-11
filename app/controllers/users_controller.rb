#encoding : utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:sigined_up, :found_password_check]

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

   def found_password_check
     user = User.where(:username=>params[:username].to_s).first
     return redirect_to new_user_password_path, :flash => {error: "用户不存在！请输入正确的用户名."} unless user 
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
