class PizzasController < ApplicationController
  before_action :main_menu_key
  helper_method :doughs, :pizzas

  def new
    if parent.present?
      @pizza = parent.deep_clone include: [:pizza_ingredients, :pizza_attributes], except: [:owner_id]
      @pizza.parent = parent
      @pizza.visibility = :for_user
    else
      @pizza = Pizza.new
      PizzaSizes.pizza_size.values.each { |value| @pizza.pizza_attributes.build(pizza_size: value) }
    end
    gon.ingredient_categories = ingredient_categories
    gon.pizza_ingredients = pizza_ingredients(@pizza)
    respond_to do |format|
      format.html
      format.js { render :new, layout: false }
    end
  end

  def create
    @pizza = Pizza.new(pizza_params)
    if @pizza.save
      redirect_to admin_pizzas_path, success: 'Пицца успешно добавлена'
    else
      gon.ingredient_categories = ingredient_categories
      gon.pizza_ingredients = pizza_ingredients(@pizza)
      respond_to do |format|
        format.html { render :new }
        format.js { render :new, layout: false }
      end
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
      { pizza_attributes_attributes: [:id, :pizza_size, :price, :weight] },
      { pizza_ingredients_attributes: [:id, :ingredient_id, :quantity, :base, :_destroy] }
    ).merge(
      { visibility: :for_user }
    )
  end
end
