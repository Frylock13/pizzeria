class Web::Admin::Orders::ApplicationController < Web::Admin::ApplicationController
  before_action :menu_key
  helper_method :order

  private

  def order
    @order ||= Order.find(params[:order_id])
  end

  def menu_key
    @menu_key = :orders
  end
end
