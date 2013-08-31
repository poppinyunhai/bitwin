require 'spec_helper'

describe Bitwin::Sms do
  context '#to' do
  	it "should works" do 
  		Bitwin::Sms.to('13301631167', "test").should include(:success, :code) 
  	end

  	it 'should batch sent message' do 
  		Bitwin::Sms.to(['13301631167','13301631167'], "test").should include(:success, :code) 
  	end
  end
end
