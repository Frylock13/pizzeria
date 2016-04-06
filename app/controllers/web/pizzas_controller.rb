# == Schema Information
#
# Table name: pizzas
#
#  id                :integer          not null, primary key
#  name              :string
#  image             :string
#  visibility        :integer          default(0)
#  owner_id          :integer
#  dough_id          :integer
#  parent_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  hot               :boolean
#  pizza_category_id :integer
#

class Web::PizzasController < Web::ApplicationController
  before_action :menu_key
  helper_method :doughs, :pizzas, :ingredients

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
    @pizza = PizzaForm.new(pizza_params).build
    if @pizza.save
      session[:profile_id] = @pizza.owner.id
      redirect_to root_path, success: 'Пицца успешно добавлена'
    else
      gon.ingredient_categories = ingredient_categories
      gon.pizza_ingredients = pizza_ingredients(@pizza)
      respond_to do |format|
        format.html { render :new }
        format.js { render :new, layout: false }
      end
    end
  end

  def recalculate
    @pizza = PizzaForm.new(pizza_params).build
    gon.ingredient_categories = ingredient_categories
    gon.pizza_ingredients = pizza_ingredients(@pizza)
    respond_to do |format|
      format.html { render :new }
      format.js { render :recalculate, layout: false }
    end
  end

  private

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

  def ingredients
    @ingredients ||= Ingredient.all.order(layer: :asc)
  end

  def menu_key
    @menu_key = :products
  end

  def pizza_params
    params.require(:pizza).permit(
      :image, :dough_id, :parent_id,
      pizza_ingredients_attributes: [:ingredient_id, :quantity]
    ).merge(owner: current_profile)
  end
end
