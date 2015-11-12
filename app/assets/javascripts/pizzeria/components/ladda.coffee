$(document).on 'ready page:load page:partial-load', ->
  $('button[type=submit]').attr
    'data-style': 'zoom-in'
    'data-spinner-color': '#383783'
  $('button[type=submit]').ladda 'bind'
