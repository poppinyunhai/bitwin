class HomeController < ApplicationController
	skip_filter :authenticate_user!

  def index
  	@ticker = Ticker.last
  	Bitwin::ThirdPartyBt.data if @ticker.nil?
  	@ticker = Bitwin::ThirdPartyBt.data if @ticker.updated_at < 2.minutes.ago
  	
  	@news = News.last
  end

end
