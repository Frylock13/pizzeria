class OrdersController < ApplicationController
  before_filter :check_order_price, only: [:new, :create]
  before_filter :require_login, only: [:index, :show]
  helper_method :address, :order, :owned_addresses, :owned_profiles,
                :payment_methods, :receiving_profile

  def index
    @main_menu_key = :orders
    # render :index if stale? [:orders] | layout_resources
  end

  def show
    @main_menu_key = :orders
    if current_user != order.ordering_profile.user && current_user != order.receiving_profile.user
      redirect_to orders_path, success: 'У вас нет доступа к данному заказу'
    end
    # render :show if stale? order | layout_resources
  end

  def new
    @main_menu_key = :new_order
    current_order.booked_on = Time.zone.now unless current_order.booked_on.present?
    # render :new if stale? [:new_order] | layout_resources
  end

  def update
    if current_order.update(order_params)
      current_order.update(booked_on: Time.zone.now) unless current_order.booked_on.present?
      User.where(email: current_order.ordering_profile.email)
          .first_or_create!(password: SecureRandom.hex(16))
      redirect_to current_order, success: 'Заказ успешно оформлен'
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

  def order
    @order ||= Order.find(params[:id])
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
