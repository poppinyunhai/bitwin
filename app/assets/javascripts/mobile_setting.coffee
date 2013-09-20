class MobileSetting
	constructor: (element) ->
		@$element = $(element)
		@mobile   = $('#mobile')
		@message	= $('#message')
		@$element.find('.bitwin-btn.bind').on 'click', $.proxy(@, 'bind_submit')

	bind_submit: (event) ->
		$target = $(event.currentTarget)
		if @mobile.val().length == 0
			@message.text("电话号码不能为空")
			@message.addClass('error')
			return false
		else if !@mobile.val().match(/^1(3|5|8)([0-9])\d{8}$/)
			@message.text("电话号码格式不正确")
			@message.addClass('error')
			return false
		else
			return true


$ ->
	$('#celphone').each ->
		new MobileSetting(this)
	
