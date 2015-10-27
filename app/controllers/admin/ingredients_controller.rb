module Admin
  class IngredientsController < AdminController
    before_action :main_menu_key
    helper_method :ingredient_categories

    def index
      @ingredient_categories = IngredientCategory.includes(:ingredients).all.order(:position)
      render :index if stale? @ingredient_categories
    end

    def new
      @ingredient = Ingredient.new
      IngredientAttribute.pizza_sizes.each do |key, value|
        @ingredient.ingredient_attributes << IngredientAttribute.new(pizza_size: key)
      end
      render :new if stale? @ingredient
    end

    def edit
      @ingredient = Ingredient.find(params[:id])
      render :edit if stale? @ingredient
    end

    def create
      @ingredient = Ingredient.new(ingredient_params)
      if @ingredient.save
        redirect_to [:edit, :admin, @ingredient], success: 'Ингредиент успешно добавлен'
      else
        render :new, change: :new_ingredient, layout: !request.xhr?
      end
    end

    def update
      @ingredient = Ingredient.find(params[:id])
      if @ingredient.update(ingredient_params)
        redirect_to [:edit, :admin, @ingredient], success: 'Ингредиент успешно обновлен'
      else
        render :edit, change: "edit_ingredient_#{@ingredient.id}", layout: !request.xhr?
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
      params.require(:ingredient).permit(
        :name, :ingredient_category_id,
        { ingredient_attributes_attributes: [:id, :pizza_size, :price, :weight] }
      )
    end
  end
end
