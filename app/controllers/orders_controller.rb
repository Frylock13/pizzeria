class OrdersController < ApplicationController
  before_filter :check_order_price, only: [:new, :create]
  helper_method :address, :owned_addresses, :owned_profiles, :payment_methods, :receiving_profile

  def index
    @main_menu_key = :orders
    # render :index if stale? [:orders] | layout_resources
  end

  def show
  end

  def new
    @main_menu_key = :new_order
    current_order.booked_on = Time.zone.now unless current_order.booked_on.present?
    # render :new if stale? [:new_order] | layout_resources
  end

  def update
    if current_order.update(order_params)
      redirect_to root_path, success: 'Заказ успешно оформлен'
      # render json: order_params
    else
      render :new
    end
  end

  private

  def check_order_price
    if current_order.price < 500
      redirect_to root_path, success: 'Пополните корзину минимум на 500 руб'
    end
  end

  def address
    @address ||= current_order.address || Address.new(owner: current_user)
  end

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

  def receiving_profile
    @receiving_profile ||= current_order.receiving_profile || Profile.new(owner: current_user)
  end

  def order_params
    params.require(:order)
          .permit(:status, :booked_on, :payment_method, :wishes,
                  :address_id,
                  { address_attributes: [:street, :house, :flat, :floor, :intercom_code, :owner_id] },
                  :receiving_profile_id,
                  { receiving_profile_attributes: [:first_name, :phone] },
                  :ordering_profile_id,
                  { ordering_profile_attributes: [:id, :email] })
  end
end
