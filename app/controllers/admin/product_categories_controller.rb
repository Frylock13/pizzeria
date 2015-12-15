module Admin
  class ProductCategoriesController < AdminController
    before_action :menu_key
    helper_method :product_category, :product_categories

    def edit
      # render :edit if stale? [product_category] | layout_resources
    end

    def create
      @product_category = ProductCategory.new(product_category_params)
      if @product_category.save
        respond_to do |format|
          format.html { redirect_to admin_products_path, success: 'Категория продукта успешно добавлена' }
          format.json { render json: @product_category }
        end
      else
        respond_to do |format|
          format.json { render json: { message: 'error' }, status: 422 }
        end
      end
    end

    def update
      if update_by_reason
        respond_to do |format|
          format.html { redirect_to admin_products_path, success: 'Категория продукта успешно обновлена' }
          format.json { render json: { message: 'Success' }, status: 200 }
        end
      else
        respond_to do |format|
          format.html {
            flash.now[:error] = 'Данные не сохранены'
            render :edit, change: "edit_product_category_#{product_category.id}", layout: !request.xhr?
          }
          format.json { render json: { errors: product_category.errors }, status: 422 }
        end
      end
    end

    def destroy
      if product_category.destroy
        flash[:success] = 'Категория успешно удалена'
      else
        flash[:success] = 'Невозможно удалить категорию'
      end
      redirect_to admin_products_path, change: :products
    end

    private

    def menu_key
      @menu_key = :products
    end

    def update_by_reason
      if product_category_params[:position] != product_category.position
        product_category.insert_at product_category_params[:position].to_i
      end
      product_category.update(product_category_params)
    end

    def product_category
      @product_category ||= ProductCategory.find(params[:id])
    end

    def product_categories
      @product_categories ||= ProductCategory.includes(:products).all.order(:position)
    end

    def product_category_params
      params.require(:product_category).permit(:name, :position)
    end
  end
end
