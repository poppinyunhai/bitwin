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
    redirect_to step2_passwords_path, :flash => {username: user.username, question: user.question.try(:description)}
  end

  def step2_post
    user = User.where(:username=>params[:username].to_s).first
    return redirect_to back_passwords_path, :flash => {error: "用户不存在！请输入正确的用户名."} unless user
    case  params[:type]
    when 'email'
      if user.email == params[:email].strip
        user.send_reset_password_instructions
        flash[:notice] = "重置密码的邮件已发送。"
        redirect_to new_user_session_path
      else
        redirect_to step2_passwords_path, :flash => {username: user.username, question: user.question.try(:description), error: "邮箱和用户名不匹配！"}
      end
    when 'question'
      if user.answer.answer.strip == params[:answer].strip
        user.send_reset_password_instructions
        redirect_to edit_user_password_path(:reset_password_token=>user.reload.reset_password_token)
      else
        redirect_to step2_passwords_path, :flash => {username: user.username, question: user.question.try(:description), error: "问题答案回答不正确！"}
      end
    else
       redirect_to step2_passwords_path, :flash => {username: user.username, question: user.question.try(:description), error: "选择验证的方式不正确！"}
    end
  end
end
