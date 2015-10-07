# $(window).load ->
#   fixed = $('.affix-panel, .navbar-fixed-top, .navbar-fixed-bottom, .modal')
#   if fixed.length
#     fixed.each ->
#       $('.body').scroll =>
#         $(this).css
#           left: -$('.body').scrollLeft()+$('.body').offset().left
