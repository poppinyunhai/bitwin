class BlankCurrency < ActiveRecord::Base
	validates :code, 
				:presence => true, 
				:uniqueness => true

	has_many :blank_accounts, dependent: :destroy
end
