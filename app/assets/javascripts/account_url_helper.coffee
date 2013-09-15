$ ->
  $("#personal-center").each ->
   	hash = window.location.hash
   	legal_hash_array = ["#personal-information","#password-safe", "#celphone","#authentication", "#IP-adress"]
   	hash = "#personal-information" if legal_hash_array.indexOf(hash)== -1
    $(hash).addClass('in')

    $(this).find('a[data-toggle="collapse"]').click (event)->
    	$target = $(event.currentTarget)
    	url = window.location
    	window.history.pushState("", "", url.origin + url.pathname + $target.attr('href')) 

