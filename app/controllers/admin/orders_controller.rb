module Admin
  class OrdersController < AdminController
    def index
      @menu_key = :orders
      if params[:status].present?
        @orders = Order.with_status(params[:status])
      else
        @orders = Order.all
      end
      @orders = @orders.includes(:ordering_profile, :receiving_profile).order(created_at: :desc)
      # render :index if stale? @orders | layout_resources
    end

    def update
      order = Order.find(params[:id])
      if order.update(order_params)
        redirect_to admin_orders_path(status: order.status), success: 'Заказ успешно обновлен'
      end
    end

    def check_updates
      date = Order.with_status(:accepted).maximum(:updated_at).to_i
      if date > params[:date].to_i
        render json: { status: 'updated', date: date }
      else
        render json: { status: 'not-updated' }
      end
    end

    private

    def order_params
      params.permit(:status)
    end
  end
end
