# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  name                :string
#  image               :string
#  description         :text
#  weight              :integer
#  price               :decimal(15, 2)
#  product_category_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  visibility          :integer          default(0)
#

class Web::ProductsController < Web::ApplicationController
  helper_method :pizza_categories, :product_categories, :user_pizzas

  def index
    @menu_key = :products
    # render :index if stale? pizzas | layout_resources
  end

  private

  def pizza_categories
    @pizza_categories ||= Pizza.with_visibility(:for_all)
                               .includes(:pizza_attributes).order(:name)
                               .group_by(&:pizza_category)
                               .sort { |a, b| a[0].position <=> b[0].position }
  end

  def product_categories
    @product_categories ||= ProductCategory.all
      .includes(products: [:features, { product_features: [:feature, :feature_value] }])
      .order(:position).order('features.name', 'feature_values.name')
  end

  def user_pizzas
    @user_pizzas ||= if current_user.present?
                       current_user.owned_pizzas.with_visibility(:for_user)
                                   .non_deleted
                                   .includes(:pizza_attributes).order(:name)
                     else
                       current_profile.owned_pizzas.with_visibility(:for_user)
                                      .non_deleted
                                      .includes(:pizza_attributes).order(:name)
                     end
  end
end
