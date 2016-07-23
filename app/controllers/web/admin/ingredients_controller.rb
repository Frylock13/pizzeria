class Web::Admin::IngredientsController < Web::Admin::ApplicationController
  before_action :menu_key
  helper_method :ingredient_categories

  def index
  end

  def new
    @ingredient = Ingredient.new
    PizzaSizes.pizza_size.values.each { |value| @ingredient.ingredient_attributes.build(pizza_size: value) }
  end

  def edit
    @ingredient = Ingredient.find(params[:id])
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

  def destroy
    @ingredient = Ingredient.find(params[:id])
    if @ingredient.destroy
      flash[:success] = 'Ингредиент успешно удален'
    else
      flash[:success] = 'Невозможно удалить ингредиент'
    end
    redirect_to admin_ingredients_path, change: :ingredients
  end

  private

  def ingredient_categories
    @ingredient_categories ||= IngredientCategory.includes(:ingredients).all.order(:position)
  end

  def menu_key
    @menu_key = :ingredients
  end

  def ingredient_params
    params.require(:ingredient).permit(
      :name, :image, :layer, :ingredient_category_id, :visibility,
      ingredient_attributes_attributes: [:id, :pizza_size, :price, :weight]
    )
  end
end
