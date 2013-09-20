class PasswordSecuritySetting
  constructor: (element, options) ->
    @$element = $(element)

    @$element.find('button.password').on 'click', $.proxy(@, 'update_password')
    @$element.find('button.question').on 'click', $.proxy(@, 'update_question')
    @$element.find('button.trade-password').on 'click', $.proxy(@, 'update_trade_password')

  
  update_password: (event)->
    $password_message = $('#password-message')

    current_password = $('#current-password').val().trim()
    if current_password.length is 0
      return $password_message.text('请输入原始密码')

    password = $('#new-password').val().trim()
    if password.length < 6
      return $password_message.text('新密码最少是6位的字串')

    password_confirm = $('#new-password-confirm').val().trim()
    if password != password_confirm
      return $password_message.text('确认密码和新密码不匹配')

    if current_password == password
      return $password_message.text('新密码和原始密码不能相同')

    payload =
      url:  '/users/update'
      type: 'PUT'
      dataType: 'json'
      data:
        type: 'password'
        password: password
        password_confirmation: password_confirm
        current_password: current_password

    @update_with_ajax(payload: payload, message: $password_message)

  update_question:() ->
    $question = $('#question').val()
    $message = $('#question-message')
    return $message.text('请选择一个安全问题') unless $question > 0

    payload =
      url:  '/users/update'
      type: 'PUT'
      dataType: 'json'
      data:
        type: 'question'
        id: $question
        answer: $('#answer-input').val()
    @update_with_ajax(payload: payload, message: $message)

  update_trade_password: ()->
    $trade_password = $('#trade-password').val().trim()
    $trade_password_confirm = $('#trade-password-confirm').val().trim()
    $current_trade_password = $('#current-trade-password').val().trim()
    $message = $('#trade-message')
    return $message.text('请输入原始密码！')  if !@$element.find('.current-trade-password').hasClass('hide') && $current_trade_password.length is 0
    return $message.text('新输入的交易密码不能为空') if $trade_password.length is 0
    return $message.text('确认密码和密码不匹配') unless $trade_password == $trade_password_confirm 

    payload =
      url:  '/users/update'
      type: 'PUT'
      dataType: 'json'
      data:
        type: 'trade'
        trade_password: $trade_password
        trade_password_confirm: $trade_password_confirm
        current_trade_password: $current_trade_password
    @update_with_ajax(payload: payload, message: $message)



  update_with_ajax: (options={})->
    dfd = $.Deferred()
    $.ajax(options.payload).success (data)=>
      options.message.text(data.message)
    .always () ->
      dfd.resolve()



$ ->
  $('#password-safe').each ->
    new PasswordSecuritySetting(this)
