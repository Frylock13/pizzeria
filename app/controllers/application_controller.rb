class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_order, :current_ordered_pizzas, :current_ordered_products,
                :current_profile, :pages

  private

  def pages
    @pages ||= Page.all.includes(:viewable_resource).order(:slug)
  end

  def forbidden
    redirect_to root_path, status: :forbidden
  end

  def not_authenticated
    render 'user_sessions/new', layout: 'application'
    # redirect_to auth_path(p: request.original_url), alert: I18n.t('sessions.not_authenticated')
  end

  def not_found
    redirect_to root_path, status: :not_found
  end

  def require_admin
    forbidden unless current_user.try(:role).try(:admin?)
  end

  def current_order
    @current_order ||= current_profile.ordering_orders.with_status(:created).first_or_initialize
  end

  def current_profile
    @current_profile ||= profile_from_session || profile_for_user || profile_for_guest
  end

  def current_ordered_pizzas
    current_order.ordered_pizzas.includes(:pizza).order('pizzas.name', :pizza_size)
  end

  def current_ordered_products
    current_order.ordered_products
                 .includes(:product, ordered_product_features: [product_feature: [:feature_value]])
                 .order('products.name', 'feature_values.name')
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

  # def layout_resources
  #   [current_user_etag, pages, revision]
  # end

  # def current_user_etag
  #   current_user || :guest
  # end

  # def revision
  #   @revision ||= { last_modified: File.atime("#{Rails.root}/REVISION").utc, etag: :revision }
  # end
end
