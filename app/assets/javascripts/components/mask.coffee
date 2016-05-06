$.fn.inputmask.noConflict()
$(document).on 'ready page:load page:partial-load', ->
  $('.mask-currency').inputmask
    alias: 'numeric'
    autoGroup: true
    digits: 2
    digitsOptional: false
    groupSeparator: ''
    placeholder: ''
    suffix: ' руб.'
  $('.mask-weight').inputmask
    alias: 'integer'
    autoGroup: true
    groupSeparator: ''
    placeholder: '0'
    suffix: ' гр.'
