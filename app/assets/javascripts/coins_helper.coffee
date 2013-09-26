class CoinsHelper
	constructor: (element) ->
		@$element = $(element)
		@$element.find('#sent-phone-code').on 'click', $.proxy(@, 'sent_phone_code')
		@$element.find('button.submit').on 'click', $.proxy(@, 'submit')

	submit: (event) ->
		$target = $(event.currentTarget)
		address = @$element.find('#address').val().trim()
		amount = @$element.find('#amount').val().trim()
		code = @$element.find('#code').val().trim()
		unless address.match(/[1-3][a-zA-Z1-9]{26,33}/)
			alert('bitcoin address invalid')
			return false
		if parseFloat(($('#coin-count').html())-0.001) < amount
			alert('amount error')
			return false
		if code.length > 0
			alert "code invalid"
		return true

	sent_phone_code: (event) ->
		$target = $(event.currentTarget)
		payload =
      url:  '/users/seed_sms_code'
      type: 'post'
      dataType: 'json'
      data:
        trade: 'bic'
  
		# $.ajax(payload).success (data)=>
  #     if data.success
  #       $target.prop('disabled', true)
  #       $target.text(data)
  #     else
  #     	$target.text(data.message)
  #   .always () ->
  #     dfd.resolve()
  	$target.text "(60)秒后点击重发"
  	# @countdown(60)
		return false

	# countdown: (count) ->
	# 	target = @$element.find('#sent-phone-code')
	# 	for x in [count..0]
	# 		setTimeout ->
	# 		  target.text("(#{x})秒后点击重发") 
	# 		,1000

$ ->
	$('#coin_tx').each ->
		new CoinsHelper(this)
	
