class Web::Admin::OrdersController < Web::Admin::ApplicationController
  helper_method :order_status_options

  def index
    @menu_key = :orders
    if params[:status].present?
      @orders = Order.with_status(params[:status])
    else
      @orders = Order.without_status(:created)
    end
    @orders = @orders.includes(:ordering_profile, :receiving_profile).order(created_at: :desc)
    # render :index if stale? @orders | layout_resources
  end

  def show
    @menu_key = :orders
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    if order.update(order_params)
      redirect_to(:back)
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

  def order_status_options
    [["Принят", "accepted"],
     ["Отправлен", "assembled"],
     ["Получен клиентом", "closed"],
     ["Отменен", "canceled"]]
  end

  def order_params
    params.permit(:status)
  end
end
