class MessageCell < Cell::Rails
	def error args
		render locals: args
	end
	
	def info args
		render locals: args
	end
end