$(document).on 'ready page:load page:partial-load', ->
  $('.slick-main:not(.slick-initialized)').slick
    accessibility: false
    arrows: true
    autoplay: true
    autoplaySpeed: 5000
    easing: 'easeInOutQuad'
    infinite: true
    pauseOnHover: false
    slidesToScroll: 1
    slidesToShow: 1
    variableWidth: false
    vertical: false
    verticalSwiping: false
  $('.slick-order-statuses:not(.slick-initialized)').slick
    accessibility: false
    arrows: false
    autoplay: false
    draggable: false
    easing: 'easeInOutQuad'
    infinite: false
    slidesToScroll: 1
    slidesToShow: 1
    swipe: false
    touchMove: false
    variableWidth: false
    vertical: false
    verticalSwiping: false
