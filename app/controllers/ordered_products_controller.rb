class OrderedProductsController < ApplicationController
  def create
    ordered_product = current_order.ordered_products
                                   .where(product_id: params[:product_id])
                                   .first_or_initialize
    ordered_product.quantity += 1
    ordered_product.save
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
