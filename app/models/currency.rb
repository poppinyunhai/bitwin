class Currency < ActiveRecord::Base
	  has_many :account_operations, dependent: :destroy
end
