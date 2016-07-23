class Web::Admin::PizzasController < Web::Admin::ApplicationController
  before_action :menu_key
  helper_method :doughs, :pizza_categories, :pizzas

  def index
  end

  def new
    @pizza = Pizza.new
    PizzaSizes.pizza_size.values.each { |value| @pizza.pizza_attributes.build(pizza_size: value) }
    gon.ingredient_categories = ingredient_categories
    gon.pizza_ingredients = []
  end

  def edit
    @pizza = Pizza.find(params[:id])
    gon.ingredient_categories = ingredient_categories
    gon.pizza_ingredients = pizza_ingredients(@pizza)
  end

  def create
    @pizza = Pizza.new(pizza_params)
    if @pizza.save
      redirect_to [:edit, :admin, @pizza], success: 'Пицца успешно добавлена'
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

  def destroy
    @pizza = Pizza.find(params[:id])
    if @pizza.destroy
      flash[:success] = 'Пицца успешно удалено'
    else
      flash[:success] = 'Невозможно удалить пиццу'
    end
    redirect_to [:admin, :pizzas], change: :pizzas
  end

  def recalculate
    pizza = Pizza.find(params[:pizza_id])
    PizzaRecalculatingService.new(pizza).recalculate
    pizza.save
    redirect_to [:edit, :admin, pizza], success: 'Стоимость пиццы успешно пересчитана'
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

  def pizza_categories
    @pizza_categories ||= PizzaCategory.includes(:pizzas).all.order(:position)
  end

  def pizzas
    @pizzas ||= Pizza.without_visibility(:for_user).order(:name)
  end

  def ingredient_categories
    @ingredient_categories ||= ActiveModel::ArraySerializer.new(
      IngredientCategory.includes(:ingredients).all.order(:position),
      each_serializer: IngredientCategorySerializer
    )
  end

  def menu_key
    @menu_key = :pizzas
  end

  def pizza_params
    params.require(:pizza).permit(
      :name, :pizza_category_id, :image, :visibility, :dough_id, :parent_id, :hot, :spicy,
      { pizza_attributes_attributes: [:id, :pizza_size, :price, :weight] },
      pizza_ingredients_attributes: [:id, :ingredient_id, :quantity, :base, :_destroy]
    )
  end
end
