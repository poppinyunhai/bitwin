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


$.fn.flash = (message, options={}) ->

  $flash = $('#flash-alert')
  if $flash
    $flash_template = """
      <div class="alert #{options.type}">
        <span class="close dismiss" data-dismiss="flash-alert">&times;</span>
        <span class="text">#{message}</span>
      </div>"""
    $flash.html($flash_template)
    $flash.show()
    options.timeout = 3000 if !options.timeout && options.hide
    if options.timeout
      setTimeout ->
        $flash.hide 'slow', ()->
          $flash.find('span.text').empty()
      , options.timeout
  else
    alert(__("Oops, unexpected error occured!"))
  null