module NavigationHelper
  def menu_link_to(*args,
                   exact_route_match: false,
                   route_without_params: false,
                   disabled: false,
                   &block)
    link = link_to(*args, &block)

    route = route_from_link(link)
    route = route_without_params(route) if route_without_params

    li_classes = []
    li_classes << route_matching_class(route, exact_route_match)
    li_classes << 'disabled' if disabled

    content_tag :li, link, class: li_classes.join(' ')
  end

  private

  def route_from_link(link)
    link.match(/href=\"([^\"]*)\"/)&.captures&.first
  end

  def route_without_params(route)
    route[/^[^?$]*/]
  end

  def route_matching_class(route, exact_route_match)
    'active' if route_matches?(route, exact_route_match)
  end

  def route_matches?(route, exact_route_match)
    if exact_route_match
      request.fullpath == url_for(route)
    else
      request.fullpath.include? url_for(route)
    end
  end
end
