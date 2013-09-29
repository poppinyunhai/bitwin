class BashInfoSetting
  constructor: (element, options) ->
    @$element = $(element)

    @$element.find('button.realname_btn').on 'click', $.proxy(@, 'update_realname')
    @$element.find('img.user_avatar').on 'click', $.proxy(@, 'show_modal')
  
  update_realname: (event)->
    realname = $('#realname_input').val().trim()
    message = $('#realname-message')
    message_text = message.find('span')
    if realname.length is 0 
      message.removeClass('success-message')
      message.addClass('error-message')
      message.show()
      message_text.text("用户名不能为空!")
      return false
    payload =
      url:  '/users/update'
      type: 'PUT'
      dataType: 'json'
      data:
        type: 'realname'
        realname: realname

    @update_with_ajax(payload: payload, message: message)


  show_modal: (event)->
    $modal = @$element.find('.user_form_modal')
    if $modal.length > 0
      $modal.modal
        show:true
        keyboard: false
        backdrop: '' 
    $modal.find('#username').val(@$element.find('p.username').text())



  update_with_ajax: (options={})->
    dfd = $.Deferred()
    $.ajax(options.payload).success (data)=>
      message = options.message
      if data.success
        $('#realname_input').prop('disabled', true)
        $('#realname_btn').prop('disabled', true)
        message.addClass('success-message')
        message.removeClass('error-message')
      else
        message.removeClass('success-message')
        message.addClass('error-message')
      message.show()
      message.find('span').text(data.message)

    .always () ->
      dfd.resolve()



$ ->
  $('#base_info_view').each ->
    new BashInfoSetting(this)
