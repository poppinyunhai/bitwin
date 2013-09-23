class CoinAccount < ActiveRecord::Base

	belongs_to :user
	belongs_to :currency

	validates :address, 
					:presence => true 
					# :uniqueness => true
end
