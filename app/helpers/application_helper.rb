module ApplicationHelper
  def menu_link_to(menu_key, *args, &block)
    content_tag :li, link_to(*args, &block), class: "#{'active' if menu_key == @menu_key}"
  end

  def tab_link(text, path, active:, disabled: nil)
    content_tag :li, class: "#{'active' if active} #{'disabled' if disabled == true}" do
      link_to path do
        concat content_tag :span, text
      end
    end
  end

  def number_to_weight(weight)
    return unless weight.present?
    "#{weight} гр."
  end

  def options_for_order_status
    options_for_select([['В ближайшее время', :accepted],
                        ['В определенный день и час', :booked]])
  end

  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def human_date(date)
    return unless date.present?
    date.in_time_zone(3).strftime('%e.%m в %k:%M')
  end
end
