$.fn.personal_nav_click = () ->
	$("#personal-nav li").removeClass('personal-nav-li-active')
	$(this).addClass('personal-nav-li-active')
	$(".personal-showbox").hide()
	type = $(this).data().type
	$("##{type}_view").show()
	window.location.replace "/account##{type}"

$ ->
	$('#personal-nav li').click (event) ->
		$target = $(event.currentTarget)
		$target.personal_nav_click() 
