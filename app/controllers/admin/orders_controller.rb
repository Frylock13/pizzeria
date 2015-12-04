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

    def check_updates
      date = Order.with_status(:accepted).maximum(:updated_at).to_s
      if date != params[:date]
        render json: { status: 'updated', date: date }
      else
        render json: { status: 'not-updated' }
      end
    end
  end
end
