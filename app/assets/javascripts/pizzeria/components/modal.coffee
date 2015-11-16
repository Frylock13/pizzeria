$.resizeDialog = (dialog, class_name) ->
  dialog.removeClass('modal-sm modal-lg')
  dialog.addClass(class_name)

$(document).on 'ready', ->
  $('#dynamic_modal').on 'hidden.bs.modal', ->
    $('#dynamic_modal').children().first().html('')
