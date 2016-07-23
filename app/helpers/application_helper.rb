module ApplicationHelper
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
