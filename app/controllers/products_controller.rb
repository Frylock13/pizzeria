class ProductsController < ApplicationController
  helper_method :pizzas, :user_pizzas, :product_categories

  def index
    @menu_key = :products
    # render :index if stale? pizzas | layout_resources
  end

  private

  def pizzas
    @pizzas ||= Pizza.with_visibility(:for_all).includes(:pizza_attributes).order(:name)
  end

  def user_pizzas
    @user_pizzas ||= if current_user.present?
                       current_user.owned_pizzas.with_visibility(:for_user)
                                   .includes(:pizza_attributes).order(:name)
                     else
                       current_profile.owned_pizzas.with_visibility(:for_user)
                                      .includes(:pizza_attributes).order(:name)
                     end
  end

  def product_categories
    @product_categories ||= ProductCategory.all
      .includes({ products: [:features, { product_features: [:feature, :feature_value] }] })
      .order(:position).order('features.name', 'feature_values.name')
  end
end
