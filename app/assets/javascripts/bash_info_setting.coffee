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
      $('body').flash("用户名不能为空!", { type:'alert-error', timeout: 3000})
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
        $('body').flash(data.message, { type:'alert-success', timeout: 3000})
        @$element.find('.real_name').html("<span>#{data.realname}</span>")
      else
        $('body').flash(data.message, { type:'alert-error', timeout: 3000})
    .always () ->
      dfd.resolve()



$ ->
  $('#base_info_view').each ->
    new BashInfoSetting(this)
