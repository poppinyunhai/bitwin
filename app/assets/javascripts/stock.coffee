$ ->
	$('.highstock').each ->
		return unless $(this)
		$.getJSON 'http://www.highcharts.com/samples/data/jsonp.php?filename=aapl-c.json&callback=?', (data)=> 
			options = 
				rangeSelector:
					selected: 1
				title:
					text : '交易大盘'
				series: [
					name: '成交价'
					data: data
					tooltip:
						valueDecimals: 2
				]


			$('.highstock').highcharts 'StockChart', options