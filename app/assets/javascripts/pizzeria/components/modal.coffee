$.resizeDialog = (dialog, class_name) ->
  dialog.removeClass('modal-sm modal-lg')
  dialog.addClass(class_name)
