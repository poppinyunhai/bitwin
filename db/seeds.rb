# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#encoding : utf-8
# q1 = Question.new
# q1.description = "我的生日是？"
# q1.save!

# q2 = Question.new
# q2.description = "我最喜欢的人的名字是？"
# q2.save!

News.find_or_create_by(content:'比特币的交易有极高的风险，它没有像中国股市那样的涨跌停限制，同时交易是24小时开放的。比特币由于筹码较少，价格易受到庄家控制，有可能出现一天价格涨几倍的情况，同时也可能出现一天内价格跌去一半的情况！入市须谨慎，一定注意控制好风险！')

Currency.find_or_create_by(code: "btc")
BlankCurrency.find_or_create_by(code: "cny")

if TradeOrder.count == 0
	1.upto(14).each do |item|
		if item%2 == 0
			TradeOrder.create(coin_account: CoinAccount.last, user: CoinAccount.last.user, amount: 1.0002, ppc: 754.00, category: 'sale', dark_pool: false, dark_pool_exclusive_match: false, state: 'active', blank_account: BlankAccount.find_by(user: CoinAccount.last.user))
		else
			TradeOrder.create(coin_account: CoinAccount.last, user: CoinAccount.last.user, amount: 1.0002, ppc: 754.00, category: 'purchase', dark_pool: false, dark_pool_exclusive_match: false, state: 'active', blank_account: BlankAccount.find_by(user: CoinAccount.last.user))
		end
	end
end

if Trade.count ==0
	7.times {
		Trade.create(coin_account: CoinAccount.last, sale_order: TradeOrder.sale_trade.first, purchase_order: TradeOrder.purchase_trade.first, seller: User.last, buyer: User.first, ppc: 740.00, traded_btc: 2.00, blank_account: BlankAccount.find_by(user: CoinAccount.last.user))
	}
end
