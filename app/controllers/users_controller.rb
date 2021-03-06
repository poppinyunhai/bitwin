#encoding : utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:sigined_up, :found_password_check]
  layout false, only: [:sms_bind,:solutions_sms_bind]

  def account
    @btc_account = current_user.btc_account   
    @ltc_account = current_user.ltc_account 
    @cny_account = current_user.cny_account
  end

  def deals
    
  end

  def info_edit
  end


  def info_update
  	Attachment.create(:attachmentable => current_user, :attachment => params[:attachment]) if params[:attachment]
    current_user.save!
  	redirect_to user_account_path
  end

  def close_google_auth
    if current_user.google_authentic?(params[:user][:google_code])
      current_user.google_auth = false
      current_user.save!
      flash[:notice] = "恭喜你，解绑google认证"
    else
      flash[:notice] = "很遗憾！解绑google认证失败"
    end
    redirect_to "/account#authentication"
  end

  def set_google_auth
    current_user.set_google_secret
    redirect_to "/account#authentication"
  end

  def google_auth
    if (current_user.google_auth = current_user.google_authentic?(params[:user][:google_code]))
      current_user.save!
      flash[:notice] = "恭喜你，google绑定成功"
    else
      flash[:notice] = "验证失败，请重试！"
    end
    redirect_to "/account#authentication"
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
    #我这里需要一个接口来实现验证码的正确与否,以及验证码发送的时间限制等条件,返回的数据格式是json, { :success => false, :message=>'原密码输入不正确!'}
    session[:mobile] = params[:user][:mobile] unless params[:user].to_s.empty?
    @seed_state = Authentication::SmsAuth.new(mobile: current_user.mobile||params[:user][:mobile]||session[:mobile], email: current_user.email)
    if @seed_state
      @info = "发送成功"
    else
      @error = "发送失败"
    end

  end

  def sms_bind
    if Authentication::SmsAuth.validate(email: current_user.email, code: params[:user][:code])
      current_user.mobile = session[:mobile]
      @result_state = current_user.save!
      @info = "绑定成功！"
      redirect_to 'account#celphone'
    else
      @error = "验证码有误, 绑定失败, 请重试!"
    end
  end

  def solutions_sms_bind
    if Authentication::SmsAuth.validate(email: current_user.email, code: params[:user][:code])
      current_user.mobile = nil
      current_user.save!
      @info = "解除绑定成功！"
      redirect_to 'account#celphone'
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

   def coin_tx
    begin
      Operation.btc_translate(current_user,params[:address],params[:amount])
      respond_to :js
    rescue Exception => e
      respond_to :js
    end
   end

  def update
    case params[:type]
    when 'password' 
      return render json: { :success => false, :message=>'原密码输入不正确!'} unless current_user.valid_password?(params[:current_password])
      return render json: { :success => false, :message=>'确认密码和输入密码不匹配!'} unless params[:password] != params[:password_confirm]
      user = current_user
      current_user.password = params[:password]
      if current_user.save!
        sign_in(user, :bypass => true)
        return render json: { :success => true, :message=>'新密码已经修改成功!'}
      end
      return render json: { :success => false, :message=>current_user.errors.full_messages}
    when 'question'
      return render json: { :success => true, :message=>'安全问题已经解除!'} if params[:answer].blank? && current_user.answer && current_user.answer.destroy
      question = Question.where(:id => params[:id]).first
      return render json: { :success => false, :message=>'输入的安全问题不合法！'} unless question
      answer = current_user.answer || current_user.build_answer
      answer.question = question
      answer.answer = params[:answer].to_s.strip
      if answer.save!
        return render json: { :success => true, :message=>'安全问题设置成功!'}
      else
        return render json: { :success => false, :message=>answer.errors.full_messages}
      end
    when 'trade'
      return render json: { :success => false, :message=>'原交易密码输入不正确!'} if current_user.trade_hash && current_user.trade_password != params[:current_trade_password]
      return render json: { :success => false, :message=>'确认密码和密码不匹配!'} unless params[:trade_password] == params[:trade_password_confirm]
      current_user.trade_password = params[:trade_password]
      return render json: { :success => true, :message=>'交易密码设置成功！'} if current_user.save!
      render json: { :success => false, :message=>current_user.errors.full_messages} 
    when 'realname'
      # return render json: { :success => false, :message=>'不能重复实名认证！'} if current_user.real_name
      return render json: { :success => false, :message=>'实名认证不能为空'} if params[:realname].blank?
      current_user.real_name = params[:realname].strip
      return render json: { :success => true, :message=>'实名认证设置成功!', :realname => current_user.real_name} if current_user.save!
      return render json: { :success => false, :message=>current_user.errors.full_messages} if current_user.save!
    else
      return render json: { :success => false, :message=>'操作不合法！'}
    end    
  end
end
