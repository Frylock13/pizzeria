$(document).ready ->
  $('.dropdown-collapse .dropdown-toggle').on 'click', (e) ->
    $(this).parent().toggleClass('open');
  dropdowns = $('.dropdown-collapse')
  if dropdowns.length
    dropdowns.each ->
      $(this).addClass('open') if $(this).find('.active').length
