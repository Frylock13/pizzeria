$(document).on 'ready page:load page:partial-load', ->
  $('.slick-main:not(.slick-initialized)').slick
    accessibility: false
    arrows: true
    autoplay: true
    autoplaySpeed: 5000
    infinite: true
    pauseOnHover: false
    slidesToScroll: 1
    slidesToShow: 1
    variableWidth: false
    vertical: false
    verticalSwiping: false
