class NewTrade
	constructor: (element) ->
		@$element = $(element)
		@total		= $('.span-result p')
		@btc 			= $('.input-price-btc')
		@cny			= $('.input-price-cny')

		@$element.find('.input-price-btc').on 'keyup', $.proxy(@, 'calculate')
		@$element.find('.input-price-cny').on 'keyup', $.proxy(@, 'calculate')

	calculate: (event) ->
		if @cny.val() != "" and @btc.val() != ""
			@total.text(((parseFloat(@btc.val())*1000) * (parseFloat(@cny.val())*1000))/1000000)
	
$ ->
	$('.exchange-floor').each ->
		new NewTrade(this)