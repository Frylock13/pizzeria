module Admin
  class IngredientsController < AdminController
    before_action :main_menu_key
    helper_method :ingredient_categories

    def index
      @ingredients = Ingredient.all.order(:name)
    end

    def show
    end

    def new
      @ingredient = Ingredient.new
    end

    def create
      @ingredient = Ingredient.new(ingredient_params)
      if @ingredient.save
        redirect_to admin_ingredients_path, success: 'Ингредиент успешно добавлен'
      else
        render :new, change: :new_ingredient, layout: !request.xhr?
      end
    end

    private

    def ingredient_categories
      @ingredient_categories ||= IngredientCategory.select(:id, :name).order(name: :asc)
    end

    def main_menu_key
      @main_menu_key = :ingredients
    end

    def ingredient_params
      params.require(:ingredient).permit(:name, :ingredient_category_id)
    end
  end
end
