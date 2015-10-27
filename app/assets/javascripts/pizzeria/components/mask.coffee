$(document).on 'ready page:load page:partial-load', ->
  $('.mask-currency').maskMoney({ thousands:'', decimal:'.' })
