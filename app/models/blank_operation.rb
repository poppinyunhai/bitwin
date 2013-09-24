class BlankOperation < ActiveRecord::Base
	belongs_to :user
	belongs_to :blank_currency
end
