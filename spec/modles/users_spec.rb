require 'spec_helper'

describe User do

  before { @user = User.new(username: "Example User", email: "user@example.com", password:'songjiayangtests', password_confirmation:'songjiayangtests') }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }

  it { should be_valid }

  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "email test" do 
  	describe "when email is not present" do
    	before { @user.email = " " }
    	it { should_not be_valid }
  	end

	  describe "when email format is invalid" do
	    it "should be invalid" do
	      addresses = %w(user@foo,com example.user@foo.)
	      addresses.each do |invalid_address|
	        @user.email = invalid_address
	        expect(@user).not_to be_valid
	      end
	    end
	  end

	  describe "when email format is valid" do
	    it "should be valid" do
	      addresses = %w(user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn)
	      addresses.each do |valid_address|
	        @user.email = valid_address
	        expect(@user).to be_valid
	      end
	    end
	  end

	  describe "email should be uniq" do 
	  	it "should be invalid" do 
	  		@user.email = (create :user).email
	  		expect(@user).not_to be_valid
	  	end
	  end
  end

  describe "password test case" do 
  	describe "when password is not present" do
	    before { @user.password = " " }
	    it { should_not be_valid }
	  end

	  describe "when password_confirmation is not present" do
	    before { @user.password_confirmation = " " }
	    it { should_not be_valid }
	  end

	  describe "when password_confirmation is not eql password" do
	    before { @user.password_confirmation = "songjiayangtests11" }
	    it { should_not be_valid }
	  end
  end
end