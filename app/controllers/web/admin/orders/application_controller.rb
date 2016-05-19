class Web::Admin::Orders::ApplicationController < Web::Admin::ApplicationController
  private

  def order
    @order ||= Order.find(params[:order_id])
  end
end
