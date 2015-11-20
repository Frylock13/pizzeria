interact('.pizza-frame').draggable
  inertia: true
  autoScroll: false
  onmove: (event) ->
    target = event.target
    center = $(target).parent().offset()
    center.left += 250
    center.top += 250
    dy = (center.left - event.pageX) / 500
    dx = (center.top - event.pageY) / 500
    angle = (parseFloat(target.getAttribute('data-angle')) or 0) + event.dx * dx - event.dy * dy
    angle -= 360 if angle >= 360
    angle += 360 if angle <= -360
    target.style.webkitTransform = target.style.transform = "rotate(#{angle}deg)"
    target.setAttribute 'data-angle', angle
    return
