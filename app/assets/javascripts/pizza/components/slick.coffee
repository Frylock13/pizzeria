$(document).ready ->
  $('.slick-main').slick
    accessibility: false
    arrows: true
    autoplay: true
    centerMode: true
    centerPadding: '25%'
    autoplaySpeed: 5000
    infinite: true
    pauseOnHover: false
    slidesToShow: 1
    slidesToScroll: 1
    variableWidth: false
    vertical: false
    verticalSwiping: false
    responsive: [
      { breakpoint: 1700, settings: { centerPadding: '17%' } }
      { breakpoint: 1500, settings: { centerPadding: '12%' } }
      { breakpoint: 1400, settings: { centerPadding: '7%' } }
      { breakpoint: 1300, settings: { centerPadding: '0%' } }
      { breakpoint: 992, settings: { centerPadding: '17%' } }
      { breakpoint: 950, settings: { centerPadding: '12%' } }
      { breakpoint: 900, settings: { centerPadding: '7%' } }
      { breakpoint: 800, settings: { centerPadding: '0%' } }
    ]
