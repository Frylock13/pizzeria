initLadda = ->
  $('button[type=submit]').attr
    'data-style': 'zoom-in'
    'data-spinner-color': '#383783'
  $('button[type=submit]').ladda 'bind'
  $('a.ladda-button').ladda 'bind'

$(document).on 'ready page:load page:partial-load', initLadda
$(document).on 'ready', ->
  $('#dynamic_modal').on 'shown.bs.modal', initLadda
