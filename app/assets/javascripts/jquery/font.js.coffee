//= require webfontloader

$(document).ready ->
  WebFont.load
    google:
      families: ['PT Sans:400,400i,700,700i:latin,cyrillic']
    active: ->
      $(window).trigger 'webfontactive'
  return
