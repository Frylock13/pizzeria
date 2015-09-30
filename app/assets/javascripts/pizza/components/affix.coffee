$(window).load ->
  resizeAffixes = ->
    affixes.each ->
      if $(this).parent().hasClass('affix-panel-dummy')
        if $(this).parent().hasClass('dummy-sync-height')
          $(this).parent().outerHeight($(this).outerHeight())
        $(this).outerWidth($(this).parent().outerWidth())

  affixes = $('.affix-panel')
  if affixes.length
    resizeAffixes()
    $(window).resize resizeAffixes
    affixes.each ->
      top = parseInt($(this).attr('data-offset-top')) || 0
      $(this).affix offset:
        top: $(this).offset().top - top
