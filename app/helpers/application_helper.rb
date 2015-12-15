module ApplicationHelper
  def menu_link_to(menu_key, *args, &block)
    content_tag :li, link_to(*args, &block), class: "#{'active' if menu_key == @menu_key }"
  end

  def tab_link(text, path, active:, disabled: nil)
    content_tag :li, class: "#{'active' if active } #{'disabled' if disabled == true }" do
      link_to path do
        concat content_tag :span, text
      end
    end
  end
end
