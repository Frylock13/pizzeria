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

    private

    def ingredient_category_params
      params.require(:ingredient_category).permit(:name)
    end
  end
end
