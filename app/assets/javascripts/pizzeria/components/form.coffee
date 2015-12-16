$(document).on 'ready page:load page:partial-load', ->
  $('form').areYouSure
    message: 'Введенные вами данные потеряются'
