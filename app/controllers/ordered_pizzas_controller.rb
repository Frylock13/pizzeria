class OrderedPizzasController < ApplicationController
  def increase
    ordered_pizza = ordered_pizzas.first_or_initialize
    ordered_pizza.quantity += 1
    ordered_pizza.save
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'shared/cart', layout: false }
    end
  end

  def decrease
    ordered_pizza = ordered_pizzas.first
    if ordered_pizza.present?
      if ordered_pizza.quantity <= 1
        ordered_pizza.destroy
      else
        ordered_pizza.quantity -= 1
        ordered_pizza.save
      end
    end
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'shared/cart', layout: false }
    end
  end

  private

  def ordered_pizzas
    @ordered_pizzas ||= current_order.ordered_pizzas
                                     .where(pizza_id: params[:pizza_id])
                                     .with_pizza_size(params[:pizza_size])
  end
end
