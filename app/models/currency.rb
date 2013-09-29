class Currency < ActiveRecord::Base
	validates :code, 
					:presence => true, 
					:uniqueness => true
					
	has_many :coin_accounts, dependent: :destroy 
end
