class ProductsController < ApplicationController
  def index
    @main_menu_key = :products
    render :index if stale? [:products, revision]
  end
end
