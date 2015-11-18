class PizzasController < ApplicationController
  before_action :main_menu_key
  helper_method :doughs, :pizzas

  def new
    @pizza = PizzaForm.new(parent_id: params[:parent_id]).build
    gon.ingredient_categories = ingredient_categories
    gon.pizza_ingredients = pizza_ingredients(@pizza)
    respond_to do |format|
      format.html
      format.js { render :new, layout: false }
    end
  end

  def create
    @pizza = PizzaForm.new(pizza_params).rebuild
    gon.ingredient_categories = ingredient_categories
    gon.pizza_ingredients = pizza_ingredients(@pizza)
    respond_to do |format|
      format.html { render :new }
      format.js { render :new, layout: false }
    end
    # if @pizza.save
    #   redirect_to admin_pizzas_path, success: 'Пицца успешно добавлена'
    # else
    # end
  end

  def recalculate
    @pizza = PizzaForm.new(pizza_params).rebuild
    respond_to do |format|
      format.html { render :new }
      format.js { render :recalculate, layout: false }
    end
  end

  private

  def parent
    @parent ||= Pizza.standard.find(params[:parent_id]) if params[:parent_id]
  end

  def doughs
    @doughs ||= Dough.all.order(name: :asc)
  end

  def pizza_ingredients(pizza)
    @pizza_ingredients ||= ActiveModel::ArraySerializer.new(
      pizza.pizza_ingredients,
      each_serializer: PizzaIngredientSerializer
    )
  end

  def pizzas
    @pizzas ||= Pizza.standard.order(name: :asc)
  end

  def ingredient_categories
    @ingredient_categories ||= ActiveModel::ArraySerializer.new(
      IngredientCategory.includes(:ingredients).all.order(:position),
      each_serializer: IngredientCategorySerializer
    )
  end

  def main_menu_key
    @main_menu_key = :products
  end

  def pizza_params
    params.require(:pizza).permit(
      :image, :dough_id, :parent_id,
      { pizza_ingredients_attributes: [:ingredient_id, :quantity] }
    )
  end
end
