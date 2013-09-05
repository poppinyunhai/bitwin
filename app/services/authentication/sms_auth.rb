module Authentication
	class SmsAuth
		def self.new args
			code = ('0'..'9').to_a.sample(6).join
			if (ChinaSMS.to args[:mobile], Settings.auth.sms_content.gsub(/code/, code))[:success] or args[:test]
				::Resque.redis.set("sms_auth_code_#{args[:email]}", code)
	      ::Resque.redis.expire("sms_auth_code_#{args[:email]}", Settings.auth.sms_code_expire)
	      return code
	    end
		end

		def self.validate args
			return true if (redis = ::Resque.redis.get("sms_auth_code_#{args[:email]}")) and redis == args[:code]
		end
	end
end