polling_orders = ->
  polling_div = $('#polling_orders').first()
  if polling_div.length
    setInterval (=>
      $.ajax
        url: Routes.check_updates_admin_orders_path()
        data:
          date: polling_div.attr('data-date')
        dataType: 'json'
        success: (response) =>
          console.log response
          if response.status == 'updated'
            polling_div.attr('data-date', response.date)
            polling_div.addClass('updated')
            $('#notification_sound')[0].play()
      return
    ), 5000

$(document).on 'ready page:load page:partial-load', polling_orders
