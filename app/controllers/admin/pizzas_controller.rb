module Admin
  class PizzasController < AdminController
    before_action :main_menu_key

    def index
      @pizzas = Pizza.all.order(:name)
      render :index if stale? @pizzas
    end

    def new
      @pizza = Pizza.new
      PizzaSizes.pizza_size.values.each do |value|
        @pizza.pizza_attributes << PizzaAttribute.new(pizza_size: value)
      end
      render :new if stale? @pizza
    end

    def edit
      @pizza = Pizza.find(params[:id])
      gon.ingredient_categories = ActiveModel::ArraySerializer.new(
        IngredientCategory.includes(:ingredients).all.order(:position),
        each_serializer: IngredientCategorySerializer
      )
      gon.pizza_ingredients = ActiveModel::ArraySerializer.new(
        @pizza.pizza_ingredients,
        each_serializer: PizzaIngredientSerializer
      )
      render :edit if stale? @pizza
    end

    def create
      @pizza = Pizza.new(pizza_params)
      if @pizza.save
        redirect_to admin_pizzas_path, success: 'Пицца успешно добавлена'
      else
        render :new, change: :new_pizza, layout: !request.xhr?
      end
    end

    def update
      @pizza = Pizza.find(params[:id])
      if @pizza.update(pizza_params)
        redirect_to [:edit, :admin, @pizza], success: 'Пицца успешно обновлена'
      else
        render :edit, change: "edit_pizza_#{@pizza.id}", layout: !request.xhr?
      end
    end

    private

    def main_menu_key
      @main_menu_key = :pizzas
    end

    def pizza_params
      params.require(:pizza).permit(
        :name, :image, :visibility,
        { pizza_attributes_attributes: [:id, :pizza_size, :price, :weight] },
        { pizza_ingredients_attributes: [:id, :ingredient_id, :quantity, :core, :_destroy] }
      )
    end
  end
end
