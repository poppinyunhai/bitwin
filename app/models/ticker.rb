class Ticker < ActiveRecord::Base

	LIMIT_TIME = Rails.env.development? ? 100 : 2

end
