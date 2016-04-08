$(document).on 'ready', ->
  if (screen.width < 700)
    document.getElementById('viewport').setAttribute('content','width=700')
