@OrdersPoller =
  request: ->
    $.ajax
      url: Routes.check_updates_admin_orders_path()
      data:
        date: @item.data('date')
      dataType: 'json'
      success: (response) =>
        if response.status == 'updated'
          @item.data('date', response.date)
          @item.addClass('updated')
          $('#notification_sound')[0].play()
  poll: ->
    that = this
    turbolinksSetInterval (=>
      that.request()
    ), 5000
  init: (item) ->
    @item = item
    @poll()

$(document).on 'ready page:load page:partial-load', ->
  if $('#polling_orders').length > 0
    setTimeout (=>
      OrdersPoller.init($('#polling_orders'))
      return
    ), 2000
