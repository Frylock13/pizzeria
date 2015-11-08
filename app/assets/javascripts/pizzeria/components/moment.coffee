moment.locale('ru')

$(document).on 'ready page:load page:partial-load', ->
  dates = $('.date-moment')
  if dates.length
    dates.each ->
      $(this).text moment($(this).text()).format('DD MMMM в hh:mm')
