class ProductsController < ApplicationController
  helper_method :pizzas, :product_categories

  def index
    @main_menu_key = :products
    # render :index if stale? pizzas | layout_resources
  end

  private

  def pizzas
    @pizzas ||= Pizza.with_visibility(:for_all).includes(:pizza_attributes).order(:name)
  end

  def product_categories
    @product_categories ||= ProductCategory.all
      .includes({ products: [:features, { product_features: [:feature, :feature_value] }] })
      .order(:position).order('features.name', 'feature_values.name')
  end
end
