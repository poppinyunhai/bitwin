//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


$.fn.show = ->
  $(this).removeClass('hide')

$.fn.hide = ->
  $(this).addClass('hide')