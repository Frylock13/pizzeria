# == Schema Information
#
# Table name: ordered_products
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  product_id :integer
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Web::OrderedProductsController < Web::ApplicationController
  def create
    ordered_product = current_order.ordered_products.includes(:ordered_product_features)
      .where(product_id: params[:product_id])
      .where('ordered_product_features.product_feature_id': params[:product_feature_id])
      .first_or_initialize
    if ordered_product.new_record? && params[:product_feature_id].present?
      ordered_product.ordered_product_features
                     .build(product_feature_id: params[:product_feature_id])
    end
    ordered_product.quantity += 1
    ordered_product.save
    session[:profile_id] = current_order.ordering_profile.id
    render_cart
  end

  def decrease
    if ordered_product.quantity <= 1
      ordered_product.destroy
    else
      ordered_product.quantity -= 1
      ordered_product.save
    end
    render_cart
  end

  def increase
    ordered_product.quantity += 1
    ordered_product.save
    render_cart
  end

  private

  def render_cart
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'shared/cart', layout: false }
    end
  end

  def ordered_product
    @ordered_product ||= OrderedProduct.find(params[:ordered_product_id])
  end
end
