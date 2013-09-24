class CoinMarket < ActiveRecord::Base
	belongs_to :currency
	belongs_to :blank_currency
end
