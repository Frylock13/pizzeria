class Web::Admin::Products::ApplicationController < Web::Admin::ApplicationController
  before_action :menu_key
  helper_method :product

  private

  def menu_key
    @menu_key = :products
  end

  def product
    @product ||= Product.find(params[:product_id])
  end
end
