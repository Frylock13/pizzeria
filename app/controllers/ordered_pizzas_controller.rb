class OrderedPizzasController < ApplicationController
  def increase
    ordered_pizza = ordered_pizzas.first_or_initialize
    ordered_pizza.quantity += 1
    ordered_pizza.save
    redirect_to root_path, change: :cart
  end

  def decrease
    ordered_pizza = ordered_pizzas.first
    if ordered_pizza.present?
      ordered_pizza.quantity -= 1
      if ordered_pizza.quantity <= 0
        ordered_pizza.destroy
      else
        ordered_pizza.save
      end
    end
    redirect_to root_path, change: :cart
  end

  private

  def ordered_pizzas
    @ordered_pizzas ||= current_order.ordered_pizzas
                                     .where(pizza_id: params[:pizza_id])
                                     .with_pizza_size(params[:pizza_size])
  end
end
