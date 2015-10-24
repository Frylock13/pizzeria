class OrdersController < ApplicationController
  def index
    @main_menu_key = :orders
    if stale? :orders
      render :index
    end
  end

  def show
  end

  def new
    @main_menu_key = :new_order
    @order = Order.new
    if stale? :new_order
      render :new
    end
  end

  def create
  end
end
