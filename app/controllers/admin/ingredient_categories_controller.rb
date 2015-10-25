module Admin
  class IngredientCategoriesController < AdminController
    def new
      @ingredient_category = IngredientCategory.new
    end

    def create
      @ingredient_category = IngredientCategory.new(ingredient_category_params)
      if @ingredient_category.save
        respond_to do |format|
          format.html { redirect_to admin_ingredients_path, success: 'Категория ингредиента успешно добавлена' }
          format.json { render json: @ingredient_category }
        end
      else
        render :new, change: :new_ingredient_category, layout: !request.xhr?
      end
    end

    def update
      if update_by_reason
        render json: { message: 'Success' }, status: 200
      else
        render json: { errors: ingredient_category.errors }, status: 422
      end
    end

    private

    def update_by_reason
      if ingredient_category_params[:position] != ingredient_category.position
        ingredient_category.insert_at ingredient_category_params[:position].to_i
      end
      ingredient_category.update(ingredient_category_params)
    end

    def ingredient_category
      @ingredient_category ||= IngredientCategory.find(params[:id])
    end

    def ingredient_category_params
      params.require(:ingredient_category).permit(:name, :position)
    end
  end
end
