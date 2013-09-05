require 'spec_helper'

describe Authentication::SmsAuth do

	before(:each) do
		@user = User.new(email: "user@example.com", mobile: '15184469287')
	end

	it "seed sms code when all info input true" do
    Authentication::SmsAuth.new(email: @user.email, mobile: @user.mobile, test: true).should_not == nil
  end

  it "validate sms code" do
		code = Authentication::SmsAuth.new(email: @user.email, mobile: @user.mobile, test: true)
		Authentication::SmsAuth.validate(email: @user.email, code: code).should == true
  end
end