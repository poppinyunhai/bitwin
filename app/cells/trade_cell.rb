class TradeCell < Cell::Rails
	def	sale_trade
		@sale_trades = TradeOrder.sale_trade.limit(7)
		render
	end

	def purchase_trade
		@purchase_trades = TradeOrder.purchase_trade.limit(7)
		render
	end

	def newest_trade
		@trades = Trade.limit(7)
		render
	end
  
  def new_trade
    render
  end
end