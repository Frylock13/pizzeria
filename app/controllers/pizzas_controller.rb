class PizzasController < ApplicationController
  before_action :main_menu_key
  helper_method :doughs, :pizzas

  def new
    @pizza = Pizza.new(parent: parent)
    PizzaSizes.pizza_size.values.each { |value| @pizza.pizza_attributes.build(pizza_size: value) }
    gon.ingredient_categories = ingredient_categories
    gon.pizza_ingredients = []
    # render :new if stale? [@pizza, ingredient_categories] | layout_resources
  end

  def create
    @pizza = Pizza.new(pizza_params)
    if @pizza.save
      redirect_to admin_pizzas_path, success: 'Пицца успешно добавлена'
    else
      render :new, change: :new_pizza, layout: !request.xhr?
    end
  end

  private

  def parent
    @parent ||= Pizza.standard.find(params[:parent_id])
  end

  def doughs
    @doughs ||= Dough.all.order(name: :asc)
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
      { pizza_attributes_attributes: [:id, :pizza_size, :price, :weight] },
      { pizza_ingredients_attributes: [:id, :ingredient_id, :quantity, :base, :_destroy] }
    ).merge(
      { visibility: :for_user }
    )
  end
end
