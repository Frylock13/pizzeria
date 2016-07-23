class Web::ApplicationController < ApplicationController
  protect_from_forgery with: :exception
  helper_method :current_order, :current_ordered_pizzas, :current_ordered_products,
                :current_profile, :pages

  private

  def forbidden
    redirect_to :root, status: :forbidden
  end

  def not_authenticated
    redirect_to :login
  end

  def current_order
    @current_order ||=
      current_profile.ordering_orders
                     .with_status(:created)
                     .first_or_initialize(ordering_profile: current_profile)
  end

  def current_ordered_pizzas
    @current_ordered_pizzas ||=
      current_order.ordered_pizzas
                   .includes(:pizza)
                   .order('pizzas.name', :pizza_size)
  end

  def current_ordered_products
    @current_ordered_products ||=
      current_order.ordered_products
                   .includes(:product, ordered_product_features: [product_feature: [:feature_value]])
                   .order('products.name', 'feature_values.name')
  end

  def current_profile
    @current_profile ||= profile_from_session || profile_for_user || profile_for_guest
  end

  def pages
    @pages ||= Page.all.includes(:viewable_resource).order(:slug)
  end

  def profile_from_session
    Profile.find_by(id: session[:profile_id]) if session[:profile_id]
  end

  def profile_for_user
    return nil unless current_user.present?
    profile = current_user.profiles.owned_by_user(current_user.id).last
    profile = Profile.new(email: current_user.email, owner_id: current_user.id) if profile.nil?
    profile
  end

  def profile_for_guest
    Profile.new
  end
end
