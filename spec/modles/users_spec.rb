require 'spec_helper'

describe User do

  before { @user = User.new(username: "Example User", email: "user@example.com", password:'songjiayangtests', password_confirmation:'songjiayangtests') }

  subject { @user }

  it { should respond_to(:username) }
  it { should respond_to(:email) }

  describe "it should be ok" do
    it { should be_valid }
  end

  describe "when username is not present" do
    before { @user.username = " " }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = " " }
    it { should_not be_valid }
  end

  describe "when email  is not a email format" do
    before { @user.email = "test.cn" }
    it { should_not be_valid }
  end

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