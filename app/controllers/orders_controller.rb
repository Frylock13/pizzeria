class OrdersController < ApplicationController
  def index
    @main_menu_key = :orders
  end

  def show
  end

  def new
    @main_menu_key = :new_order
    @order = Order.new
  end

  def create
  end
end
