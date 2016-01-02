$(document).on 'ready page:load page:partial-load', ->
  turbolinks = $('a[data-change]')
  if turbolinks.length
    turbolinks.each ->
      unless $(this).hasClass('turbolink-initialized')
        $(this).on 'click', (event) ->
          Turbolinks.visit($(this).attr('href'), { change: $(this).data('change') })
          event.preventDefault()
        $(this).addClass('turbolink-initialized')
