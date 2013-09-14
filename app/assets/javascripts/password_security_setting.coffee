class PasswordSecuritySetting
  constructor: (element, options) ->
    @$element = $(element)

    @$element.find('button.password').on 'click', $.proxy(@, 'update_password')
  
  update_password: (event)->
    $target = $(event.currentTarget)
    $password_message = $('#password-message')

    current_password = $('#current-password').val().trim()
    if current_password.length is 0
      return $password_message.text('请输入原始密码')

    password = $('#new-password').val().trim()
    if password.length < 6
      return $password_message.text('密码最少为6位')

    password_confirm = $('#new-password-confirm').val().trim()
    if password != password_confirm
      return $password_message.text('确认密码和新密码不匹配')

    if current_password == password
      return $password_message.text('新密码和原密码相同.')

    payload =
      url:  '/users/update'
      type: 'PUT'
      dataType: 'json'
      data:
        type: 'password'
        password: password
        password_confirmation: password_confirm
        current_password: current_password

    dfd = $.Deferred()
    $.ajax(payload).success (data)=>
      $password_message.text(data.message)
    .always () ->
      dfd.resolve()

$ ->
  $('#password-safe').each ->
    new PasswordSecuritySetting(this)
