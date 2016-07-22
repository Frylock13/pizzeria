class Web::Admin::WelcomeController < Web::Admin::ApplicationController
  def index
    @menu_key = :dashboard
    @today_orders = Order.without_status(:created)
                         .without_status(:canceled)
                         .where('updated_at BETWEEN ? AND ?',
                                Time.zone.now.beginning_of_day,
                                Time.zone.now.end_of_day)
    @week_orders = Order.without_status(:created)
                        .without_status(:canceled)
                        .where('updated_at BETWEEN ? AND ?',
                               Time.zone.now.beginning_of_day - 7.days,
                               Time.zone.now.end_of_day)
  end
end
