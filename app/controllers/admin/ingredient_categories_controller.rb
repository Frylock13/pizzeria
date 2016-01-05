module Admin
  class IngredientCategoriesController < AdminController
    before_action :menu_key
    helper_method :ingredient_category, :ingredient_categories

    def edit
      # render :edit if stale? [ingredient_category] | layout_resources
    end

    def create
      @ingredient_category = IngredientCategory.new(ingredient_category_params)
      if @ingredient_category.save
        respond_to do |format|
          format.html { redirect_to admin_ingredients_path, success: 'Категория ингредиента успешно добавлена' }
          format.json { render json: @ingredient_category }
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
          format.html { redirect_to admin_ingredients_path, success: 'Категория ингредиента успешно обновлена' }
          format.json { render json: { message: 'Success' }, status: 200 }
        end
      else
        respond_to do |format|
          format.html do
            flash.now[:error] = 'Данные не сохранены'
            render :edit, change: "edit_ingredient_category_#{ingredient_category.id}", layout: !request.xhr?
          end
          format.json { render json: { errors: ingredient_category.errors }, status: 422 }
        end
      end
    end

    def destroy
      if ingredient_category.destroy
        flash[:success] = 'Категория успешно удалена'
      else
        flash[:success] = 'Невозможно удалить категорию'
      end
      redirect_to admin_ingredients_path, change: :ingredients
    end

    private

    def menu_key
      @menu_key = :ingredients
    end

    def update_by_reason
      if ingredient_category_params[:position] != ingredient_category.position
        ingredient_category.insert_at ingredient_category_params[:position].to_i
      end
      ingredient_category.update(ingredient_category_params)
    end

    def ingredient_category
      @ingredient_category ||= IngredientCategory.find(params[:id])
    end

    def ingredient_categories
      @ingredient_categories ||= IngredientCategory.includes(:ingredients).all.order(:position)
    end

    def ingredient_category_params
      params.require(:ingredient_category).permit(:name, :position)
    end
  end
end
