#encoding:utf-8

require 'spec_helper.rb'

describe "Home page" do 
	it "should have content '登录'" do 
		visit '/'
		page.should have_content '登录'
	end
end

