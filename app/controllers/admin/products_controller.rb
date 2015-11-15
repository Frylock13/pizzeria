module Admin
  class ProductsController < AdminController
    before_action :main_menu_key
    helper_method :product_categories

    def index
      # render :index if stale? @product_categories | layout_resources
    end

    def new
      @product = Product.new
      # render :new if stale? [@product, product_categories] | layout_resources
    end

    def edit
      @product = Product.find(params[:id])
      # render :edit if stale? [@product, product_categories] | layout_resources
    end

    def create
      @product = Product.new(product_params)
      if @product.save
        redirect_to [:edit, :admin, @product], success: 'Продукт успешно добавлен'
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

    def destroy
      @product = Product.find(params[:id])
      if @product.destroy
        flash[:success] = 'Продукт успешно удален'
      else
        flash[:success] = 'Невозможно удалить продукт'
      end
      redirect_to admin_products_path, change: :products
    end

    private

    def main_menu_key
      @main_menu_key = :products
    end

    def product_categories
      @product_categories ||= ProductCategory.includes(:products).all.order(:position)
    end

    def product_params
      params.require(:product).permit(
        :name, :product_category_id, :image, :visibility, :weight, :price
      )
    end
  end
end
