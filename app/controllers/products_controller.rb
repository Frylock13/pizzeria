class ProductsController < ApplicationController
  def index
    @main_menu_key = :products
    render :index if stale? [:products] | layout_resources
  end
end
