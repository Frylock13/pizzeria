intervals = []
timeouts = []

clearPolling = ->
  for interval of intervals
    window.clearInterval interval
  for timeout of timeouts
    window.clearTimeout timeout

pollingOrder = ->
  setTimeout (=>
    Turbolinks.visit(window.location.href, { change: ['polling_order'] })
    return
  ), 5000

pollingOrders = (item) ->
  setInterval (=>
    $.ajax
      url: Routes.check_updates_admin_orders_path()
      data:
        date: item.attr('data-date')
      dataType: 'json'
      success: (response) =>
        console.log response
        if response.status == 'updated'
          item.attr('data-date', response.date)
          item.addClass('updated')
          $('#notification_sound')[0].play()
    return
  ), 5000

$(document).on 'page:before-change page:before-unload', clearPolling

$(document).on 'ready page:load page:partial-load', ->
  if $('#polling_order').first().length
    timeouts.push pollingOrder()
  item = $('#polling_orders').first()

  if item.length
    unless item.hasClass('enabled')
      intervals.push pollingOrders()
      item.addClass('enabled')
