$.fn.show = ->
  $(this).removeClass('hide')

$.fn.hide = ->
  $(this).addClass('hide')

class PassworBack
  constructor: (element, options) ->
    that = this
    @$element = $(element)
    @username = $('#username')
    @message = @$element.find('.message')
    @question = @$element.find('.question')
    @answer = @$element.find('.answer')
    @email = @$element.find('.email')

    @$element.find('.step-1.submit').on 'click', $.proxy(@, 'step1_submit')
    @$element.find('.step-2.submit').on 'click', $.proxy(@, 'step2_submit')
    $('#type').on 'change', $.proxy(@, 'select_type')

  step1_submit: (event)->
    $target = $(event.currentTarget)
    if @username.val().length == 0
      @message.text("用户名不能为空")
      @message.addClass('error')
      return false
    return true

  step2_submit: (event)->
    $target = $(event.currentTarget)
    type = $('#type').val()
    if type is 'question' && @answer.find('input').val().length is 0
      @message.text("问题答案不能为空！")
      @message.addClass('error')
      return false
    else if type is 'email' &&  @email.find('input').val().length is 0
      @message.text("邮箱地址不能空！")
      @message.addClass('error')
      return false
    return true

  select_type: (element)->
    $target = $(event.currentTarget)
    type = $target.val()
    if type is 'question'
      if @$element.find('p.devise-question').text().trim().length is 0
        @message.text("对不起该用户没有设置安全问题。")
        $target.val('email')
      else 
        @question.show()
        @answer.show()
        @email.hide()
    else
      @question.hide()
      @answer.hide()
      @email.show()

$ ->
  $('#password_back').each ->
    new PassworBack(this)
