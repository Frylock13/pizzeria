module Admin
  class ProductsController < AdminController
    before_action :main_menu_key
    helper_method :product_categories

    def index
      @product_categories = ProductCategory.includes(:products).all.order(:position)
      render :index if stale? @product_categories
    end

    def new
      @product = Product.new
      render :new if stale? [@product, product_categories]
    end

    def edit
      @product = Product.find(params[:id])
      render :edit if stale? [@product, product_categories]
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to admin_products_path, success: 'Продукт успешно добавлен'
      else
        render :new, change: :new_product, layout: !request.xhr?
      end
    end

    def update
      @product = Product.find(params[:id])
      if @product.update(product_params)
        redirect_to [:edit, :admin, @product], success: 'Продукт успешно обновлен'
      else
        render :edit, change: "edit_product_#{@product.id}", layout: !request.xhr?
      end
    end

    private

    def product_categories
      @product_categories ||= ProductCategory.all.order(name: :asc)
    end

    def main_menu_key
      @main_menu_key = :products
    end

    def product_params
      params.require(:product).permit(
        :name, :product_category_id, :image, :visibility, :weight, :price
      )
    end
  end
end