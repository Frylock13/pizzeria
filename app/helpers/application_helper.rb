module ApplicationHelper
  def main_menu_link(path, active_key, icon, text)
    content_tag :li, class: "#{'active' if active_key == @main_menu_key }" do
      link_to path do
        concat content_tag :span, '', class: "fa #{icon}" if icon.present?
        concat content_tag :span, text
      end
    end
  end

  def tab_link(text, path, active:, disabled: nil)
    content_tag :li, class: "#{'active' if active } #{'disabled' if disabled == true }" do
      link_to path do
        concat content_tag :span, text
      end
    end
  end
end
