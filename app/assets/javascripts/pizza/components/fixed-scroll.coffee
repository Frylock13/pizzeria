$(window).load ->
  fixed = $('.affix-panel, .navbar-fixed-top, .navbar-fixed-bottom, .modal')
  if fixed.length
    fixed.each ->
      $(window).scroll =>
        $(this).css
          left: -$(window).scrollLeft()
