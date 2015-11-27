class OrdersController < ApplicationController
  before_filter :check_order_price, only: [:new, :create]

  def index
    @main_menu_key = :orders
    # render :index if stale? [:orders] | layout_resources
  end

  def show
  end

  def new
    @main_menu_key = :new_order
    @order = OrderDummy.new
    # render :new if stale? [:new_order] | layout_resources
  end

  def create
  end

  private

  def check_order_price
    if current_order.price < 500
      redirect_to root_path, success: 'Пополните корзину минимум на 500 руб'
    end
  end
end
