class OrdersController < ApplicationController
  def index
    @main_menu_key = :orders
    # render :index if stale? [:orders] | layout_resources
  end

  def show
  end

  def new
    @main_menu_key = :new_order
    @order = Order.new
    # render :new if stale? [:new_order] | layout_resources
  end

  def create
  end
end
