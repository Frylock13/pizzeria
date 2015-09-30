//= require smooth-scroll

$(document).ready ->
  if $('.navbar-toggle').length
    $('.navbar-toggle').each ->
      $(this).tooltip
        placement: 'left'
