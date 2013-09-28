//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .


$.fn.show = () ->
  $(this).removeClass('hide')
  $(this).addClass('show')

$.fn.hide = () ->
  $(this).addClass('hide')
  $(this).removeClass('show')