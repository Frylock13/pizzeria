class Web::Admin::Orders::OrderedPizzasController < Web::Admin::Orders::ApplicationController
  def destroy
    price = order.price
    if ordered_pizza.destroy
      BonusPointsRecalculationService.new(order, price).recalculate
      flash[:success] = 'Товар успешно удален'
    else
      flash[:success] = 'Невозможно удалить товар'
    end
    redirect_to [:admin, order]
  end

  private

  def ordered_pizza
    @ordered_pizza = OrderedPizza.find(params[:id])
  end
end
