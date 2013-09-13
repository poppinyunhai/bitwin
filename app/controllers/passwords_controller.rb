#encoding : utf-8
class PasswordsController < ApplicationController
  skip_filter :authenticate_user!


  def step1

  end

  def step2
    return redirect_to back_passwords_path unless flash[:username]
  end

  def step1_post
    user = User.where(:username=>params[:username].to_s).first
    return redirect_to back_passwords_path, :flash => {error: "用户不存在！请输入正确的用户名."} unless user
    redirect_to step2_passwords_path, :flash => {username: user.username}
  end

  def step2_post
    user = User.where(:username=>params[:username].to_s).first
    return redirect_to back_passwords_path, :flash => {error: "用户不存在！请输入正确的用户名."} unless user
  end
end
