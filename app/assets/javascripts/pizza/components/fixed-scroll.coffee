$(window).load ->
  fixed = $('.affix-panel, .navbar-fixed-top, .navbar-fixed-bottom')
  if fixed.length
    fixed.each ->
      $(window).scroll =>
        $(this).css
          left: -$(window).scrollLeft()
