class HomeController < ApplicationController
	skip_filter :authenticate_user!

  def index
  	@ticker = Ticker.last
  	@ticker = Bitwin::ThirdPartyBt.data if (@ticker.nil? || @ticker.updated_at < Ticker::LIMIT_TIME.minutes.ago)
  	
  	@news = News.last
  end

end
