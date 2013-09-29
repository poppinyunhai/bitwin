class UserObserver < ActiveRecord::Observer

  observe User

  def before_update(record)
  	if record.changed_attributes.has_key?("current_sign_in_at")
  	LoginHistory.create!(ip_address: record.current_sign_in_ip, area: TaobaoGeoIP.new(record.current_sign_in_ip).to_s, action_type: 'LoginIn', user: record)
	  end
  end
  
end

class TaobaoGeoIP
	def to_s
		result ||= []
		result << self.country
		result << self.region
		result << self.city
		result.join('/')
	end
end
