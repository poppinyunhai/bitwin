module Bitwin
	module ThirdPartyBt
		def self.data
			@agent ||= Mechanize.new
			data = JSON.parse @agent.get('https://www.bitstamp.net/api/ticker/').body
			ticker = Ticker.last || Ticker.new
			ticker.update_attributes( {
						last_price: (data['last'].to_f*6.1183).round(1),
						lowest_sell: (data['low'].to_f*6.1183).round(1),
						high_buy: (data['high'].to_f*6.1183).round(1),
						open_price: (data['bid'].to_f*6.1183).round(1),
						volume: data['volume'].to_i
				})
		end
	end
end
