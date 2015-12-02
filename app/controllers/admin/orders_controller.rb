module Admin
  class OrdersController < AdminController
    def index
      @main_menu_key = :orders
      if params[:status].present?
        @orders = Order.with_status(params[:status])
      else
        @orders = Order.all
      end
      @orders = @orders.includes(:ordering_profile, :receiving_profile).order(created_at: :desc)
      # render :index if stale? @orders | layout_resources
    end
  end
end
