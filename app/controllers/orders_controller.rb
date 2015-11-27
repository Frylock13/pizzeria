class OrdersController < ApplicationController
  before_filter :check_order_price, only: [:new, :create]
  helper_method :owned_addresses, :owned_profiles, :payment_methods

  def index
    @main_menu_key = :orders
    # render :index if stale? [:orders] | layout_resources
  end

  def show
  end

  def new
    @main_menu_key = :new_order
    current_order.booked_on = Time.zone.now
    # render :new if stale? [:new_order] | layout_resources
  end

  def update
    render json: params
  end

  private

  def owned_addresses
    return [] unless current_user.present?
    @owned_addresses ||= current_user.owned_addresses.map{ |item| [item.to_s, item.id] }
  end

  def owned_profiles
    return [] unless current_user.present?
    @owned_profiles ||= current_user.owned_profiles.map{ |item| [item.to_s, item.id] }
  end

  def payment_methods
    @payment_methods ||= OrderEnums.payment_method.options
  end

  def check_order_price
    if current_order.price < 500
      redirect_to root_path, success: 'Пополните корзину минимум на 500 руб'
    end
  end
end
