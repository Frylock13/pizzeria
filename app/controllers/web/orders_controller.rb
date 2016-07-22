# == Schema Information
#
# Table name: orders
#
#  id                   :integer          not null, primary key
#  address_id           :integer
#  status               :string
#  wishes               :text
#  receiving_profile_id :integer
#  ordering_profile_id  :integer
#  payment_method       :string
#  booked_on            :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class Web::OrdersController < Web::ApplicationController
  before_filter :check_order_price, only: [:new, :create]
  before_filter :require_login, only: [:index, :show]
  helper_method :address, :order, :addresses, :owned_profiles,
                :payment_methods, :receiving_profile

  def index
    @menu_key = :orders
    # render :index if stale? [:orders] | layout_resources
  end

  def show
    @menu_key = :orders
    # render :show if stale? order | layout_resources
  end

  def new
    @menu_key = :new_order
    current_order.booked_on = Time.zone.now unless current_order.booked_on.present?
    # render :new if stale? [:new_order] | layout_resources
  end

  def update
    if current_order.update(order_params)
      order_creating_service = OrderCreatingService.new(current_order)
      order_creating_service.submit
      auto_login(order_creating_service.user)
      redirect_to current_order, success: 'Заказ успешно оформлен'
    else
      render :new
    end
  end

  def clear
    current_order.ordered_pizzas.destroy_all
    current_order.ordered_products.destroy_all
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'sidebar_cart', layout: false }
    end
  end

  def status
    @order = Order.find(params[:order_id])
    render json: { status: @order.status }
  end

  private

  def check_order_price
    if current_order.price < ENV['APP_MINIMAL_ORDER_COST'].to_i
      redirect_to root_path,
                  success: "Пополните корзину минимум на #{ENV['APP_MINIMAL_ORDER_COST']} руб"
    end
  end

  def address
    @address ||= current_order.address || Address.new(owner: current_user)
  end

  def addresses
    return pickup_addresses unless current_user.present?
    user_addresses + pickup_addresses
  end

  def pickup_addresses
    @pickup_addresses ||= Address.where(pickup: true).map { |item| [item.to_s, item.id] }
  end

  def user_addresses
    @user_addresses ||= current_user.owned_addresses.map { |item| [item.to_s, item.id] }
  end

  def owned_profiles
    return [] unless current_user.present?
    @owned_profiles ||= current_user.owned_profiles.map { |item| [item.to_s, item.id] }
  end

  def order
    @order ||= current_user.orders.find(params[:id])
  end

  def payment_methods
    @payment_methods ||= OrderEnums.payment_method.options
  end

  def receiving_profile
    @receiving_profile ||= current_order.receiving_profile || Profile.new(owner: current_user)
  end

  def order_params
    params.require(:order).permit(
      :status, :booked_on, :payment_method, :wishes, :discount_card_number,
      :address_id, { address_attributes: [:city, :street, :house, :entrance, :flat,
                                          :floor, :intercom_code, :owner_id] },
      :receiving_profile_id, { receiving_profile_attributes: [:first_name, :phone] },
      :ordering_profile_id, ordering_profile_attributes: [:id, :email]
    )
  end
end
