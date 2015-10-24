class ProductsController < ApplicationController
  def index
    @main_menu_key = :products
    if stale? :products
      render :index
    end
  end
end
