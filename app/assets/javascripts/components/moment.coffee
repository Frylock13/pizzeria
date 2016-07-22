moment.locale('ru')

$(document).on 'ready page:load page:partial-load', ->
  dates = $('.moment-date')
  if dates.length
    dates.each ->
      $(this).text moment.utc($(this).text(), 'YYYY-MM-DD HH:mm:ss Z').local().format('DD MMMM в HH:mm')
