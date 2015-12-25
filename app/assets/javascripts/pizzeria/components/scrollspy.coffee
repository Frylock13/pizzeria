$(document).on 'ready page:load page:partial-load', ->
  if $('.affix-products').length
    $('body').scrollspy
      offset: 120
      target: ''
