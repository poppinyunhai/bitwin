class TradeOrder < ActiveRecord::Base

	default_scope { order("created_at DESC") }

	belongs_to :user
  belongs_to :coin_account
  belongs_to :blank_account

  has_many :sale_trades,
			     :class_name => "Trade",
			     :foreign_key => :sale_order_id,
			     :dependent => :nullify

  has_many :purchase_trades,
			     :class_name => "Trade",
			     :foreign_key => :purchase_order_id,
			     :dependent => :nullify

	scope :purchase_trade, -> {
  	where(state: "active", category: "purchase")
  }

	scope :sale_trade, -> {
  	where(state: "active", category: "sale")
  }

	state_machine :initial => :active do
    event :revoke do
      transition :active => :revoke
    end

    event :recover do
      transition :revoke => :active
    end

		event :close do
      transition [:revoke, :active] => :closed
    end    

  end

end
