$ ->
  $("#personal-center").each ->
   	hash = window.location.hash.split('#').pop()
   	legal_hash_array = ["base_info","recharge", "withdraw","password", "sms", "google", "ips"]
   	hash = "base_info" if legal_hash_array.indexOf(hash)== -1
    $("li[data-type=#{hash}]").personal_nav_click()


