class Web::Admin::Orders::OrderedPizzasController < Web::Admin::Orders::ApplicationController
  helper_method :pizza_categories, :user_pizzas

  def new
  end

  def create
    price = order.price
    ordered_pizza = order.ordered_pizzas
                         .where(pizza_id: params[:pizza_id])
                         .with_pizza_size(params[:pizza_size])
                         .first_or_initialize
    ordered_pizza.quantity += 1
    if ordered_pizza.save
      BonusPointsRecalculationService.new(order, price).recalculate
      flash[:success] = 'Товар успешно добавлен'
    else
      flash[:error] = 'Невозможно добавить товар'
    end
    redirect_to [:admin, order]
  end

  def destroy
    price = order.price
    if ordered_pizza.destroy
      BonusPointsRecalculationService.new(order, price).recalculate
      flash[:success] = 'Товар успешно удален'
    else
      flash[:error] = 'Невозможно удалить товар'
    end
    redirect_to [:admin, order]
  end

  private

  def pizza_categories
    @pizza_categories ||= Pizza.with_visibility(:for_all)
                               .includes(:pizza_attributes).order(:name)
                               .group_by(&:pizza_category)
                               .sort { |item| item[0].position }
  end

  def user_pizzas
    @user_pizzas ||= current_user.owned_pizzas.with_visibility(:for_user)
                                 .non_deleted
                                 .includes(:pizza_attributes).order(:name)
  end

  def ordered_pizza
    @ordered_pizza = OrderedPizza.find(params[:id])
  end
end
