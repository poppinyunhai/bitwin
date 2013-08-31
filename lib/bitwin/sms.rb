module Bitwin
	module Sms
		def self.to(phone,message)
			ChinaSMS.use Settings.china_sms.server.to_sym, username: Settings.china_sms.username, password: Settings.china_sms.password
			ChinaSMS.to phone, message
		end
	end
end
