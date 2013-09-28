class NewTrade
	constructor: (element) ->
		@$element     = $(element)
		@total		    = $('.span-result p')
		@btc 			    = $('.input-price-btc')
		@cny			    = $('.input-price-cny')
		@category     = $("#select")
		@coin_account = $('#coin_account')


		@$element.find('.input-price-btc').on 'keyup', $.proxy(@, 'calculate')
		@$element.find('.input-price-cny').on 'keyup', $.proxy(@, 'calculate')
		@$element.find('#select').on 'change', $.proxy(@, 'calculate')
		@$element.find('.submit-button').on 'click', $.proxy(@, 'submit')

	submit: (event) ->
		$('#trade_order_coin_account_id').val(@coin_account.val())
		if @cny.val() == "" or @btc.val() == "" or !@cny.val().match(/^[0-9]*\.?[0-9]*$/) or !@btc.val().match(/^[0-9]*\.?[0-9]*$/)
			return false
		else
			return true
		

	calculate: (event) ->
		if @category.val() == "purchase"
			@symbol = "-￥"
		else
			@symbol = "+￥"
		
		if @cny.val() != "" and @btc.val() != ""
			@total.text(@symbol + ((parseFloat(@btc.val())*1000) * (parseFloat(@cny.val())*1000))/1000000)
		else
			@total.text("0")
	
$ ->
	$('.exchange-floor').each ->
		new NewTrade(this)