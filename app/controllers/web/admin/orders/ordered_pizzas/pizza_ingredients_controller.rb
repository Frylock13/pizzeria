class Web::Admin::Orders::OrderedPizzas::PizzaIngredientsController < Web::Admin::Orders::OrderedPizzas::ApplicationController
  def destroy
    if pizza_ingredient.destroy
      PizzaRecalculatingService.new(ordered_pizza.pizza).recalculate
      ordered_pizza.pizza.save
      flash[:success] = 'Ингредиент успешно удален'
    else
      flash[:error] = 'Невозможно удалить ингредиент'
    end
    redirect_to [:admin, order]
  end

  private

  def pizza_ingredient
    @pizza_ingredient = PizzaIngredient.find(params[:id])
  end
end
