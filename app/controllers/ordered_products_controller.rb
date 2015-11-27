class OrderedProductsController < ApplicationController
  def increase
    ordered_product = ordered_products.first_or_initialize
    ordered_product.quantity += 1
    ordered_product.save
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'shared/cart', layout: false }
    end
  end

  def decrease
    ordered_product = ordered_products.first
    if ordered_product.present?
      if ordered_product.quantity <= 1
        ordered_product.destroy
      else
        ordered_product.quantity -= 1
        ordered_product.save
      end
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'shared/cart', layout: false }
    end
  end

  private

  def ordered_products
    @ordered_products ||= current_order.ordered_products.where(product_id: params[:product_id])
  end
end
