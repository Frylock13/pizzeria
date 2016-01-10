@OrderStatusAnimator =
  colorProgress: (klass = '') ->
    @progress.removeClass('progress-bar-success')
    @progress.removeClass('progress-bar-info')
    @progress.removeClass('progress-bar-warning')
    @progress.removeClass('progress-bar-danger')
    @progress.addClass(klass)
  goTo: (status) ->
    @status = status
    switch status
      when 'created'
        @progress.width('30%')
        @progress.addClass('progress-bar-striped active')
        @colorProgress()
        @progress.text('Заказ Оформляется')
        @slider.slick('slickGoTo', 1)
      when 'booked'
        @progress.width('40%')
        @progress.addClass('progress-bar-striped active')
        @colorProgress('progress-bar-info')
        @progress.text('Заказ Забронирован')
        @slider.slick('slickGoTo', 2)
      when 'accepted'
        @progress.width('50%')
        @progress.addClass('progress-bar-striped active')
        @colorProgress('progress-bar-success')
        @progress.text('Заказ Принят')
        @slider.slick('slickGoTo', 3)
      when 'assembled'
        @progress.width('70%')
        @progress.addClass('progress-bar-striped active')
        @colorProgress('progress-bar-warning')
        @progress.text('Заказ Собран')
        @slider.slick('slickGoTo', 4)
      when 'delivered'
        @progress.width('90%')
        @progress.addClass('progress-bar-striped active')
        @colorProgress('progress-bar-danger')
        @progress.text('Заказ Доставлен')
        @slider.slick('slickGoTo', 5)
      when 'closed'
        @progress.width('100%')
        @progress.removeClass('progress-bar-striped active')
        @colorProgress('progress-bar-success')
        @progress.text('Заказ Выполнен')
        @slider.slick('slickGoTo', 6)
      when 'canceled'
        @progress.width('100%')
        @progress.removeClass('progress-bar-striped active')
        @colorProgress()
        @progress.text('Заказ Отменен')
        @slider.slick('slickGoTo', 7)
  request: ->
    $.ajax
      url: Routes.order_status_path(@order.data('order'))
      data:
        status: @status
      dataType: 'json'
      success: (response) =>
        if response.status != @status
          @goTo(response.status)
          $('#notification_sound')[0].play()
  poll: ->
    that = this
    turbolinksSetInterval (=>
      that.request()
    ), 2000
  init: (order) ->
    @order = order
    @progress = order.find('.progress-bar')
    @slider = order.find('.slick-slider')
    @goTo(@order.data('status'))
    @poll()

$(document).on 'ready page:load page:partial-load', ->
  $('#polling_order').find('.slick-slider').on 'init', (event, slick) ->
    setTimeout (=>
      OrderStatusAnimator.init($('#polling_order'))
      return
    ), 2000
