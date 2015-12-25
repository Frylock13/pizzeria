$(document).on 'ready page:load page:partial-load', ->
  affixes = $('.affix-products')
  if affixes.length
    affixes.each ->
      $(this).affix offset:
        top: =>
          @top = $(this).prev().offset().top + $(this).prev().outerHeight(true) - 0
  affixes = $('.affix-pizza-categories')
  if affixes.length
    affixes.each ->
      $(this).affix offset:
        top: =>
          @top = $(this).closest('section').offset().top - 50 + 10 + 80
        bottom: =>
          @bottom = $(this).closest('section').outerHeight(true)
