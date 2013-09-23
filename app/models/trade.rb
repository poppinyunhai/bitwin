class Trade < ActiveRecord::Base

  belongs_to :account_operation, class_name: "AccountOperation"
	belongs_to :purchase_order, 	 class_name: "TradeOrder"
  belongs_to :sale_order, 			 class_name: "TradeOrder"
  belongs_to :seller, 					 class_name: "User"
  belongs_to :buyer, 						 class_name: "User"

	scope :last_24h, -> {
    where("created_at >= ?", DateTime.now.advance(:hours => -24))
  }
  
  scope :last_week, -> {
    where("created_at >= ?", DateTime.now.advance(:days => -7))
  }

end