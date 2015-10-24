module Admin
  class IngredientsController < AdminController
    before_action :main_menu_key

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
        render :new
      end
    end

    private

    def main_menu_key
      @main_menu_key = :ingredients
    end

    def ingredient_params
      params.require(:ingredient).permit(:name)
    end
  end
end
