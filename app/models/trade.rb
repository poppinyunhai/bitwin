class Trade < ActiveRecord::Base

  default_scope { order("created_at DESC") }

  belongs_to :coin_account
	belongs_to :purchase_order, 	 class_name: "TradeOrder"
  belongs_to :sale_order, 			 class_name: "TradeOrder"
  belongs_to :seller, 					 class_name: "User"
  belongs_to :buyer, 						 class_name: "User"
  belongs_to :blank_account

  def self.trades user
    where("seller_id = #{user.id} or buyer_id = #{user.id}")
  end

  def category user
    self.seller == user ? "sale" : "purchase"
  end

	scope :last_24h, -> {
    where("created_at >= ?", DateTime.now.advance(:hours => -24))
  }
  
  scope :last_week, -> {
    where("created_at >= ?", DateTime.now.advance(:days => -7))
  }

end
