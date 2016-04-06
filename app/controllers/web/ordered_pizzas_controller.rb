# == Schema Information
#
# Table name: ordered_pizzas
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  pizza_id   :integer
#  quantity   :integer          default(0)
#  pizza_size :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Web::OrderedPizzasController < Web::ApplicationController
  def create
    ordered_pizza = current_order.ordered_pizzas
                                 .where(pizza_id: params[:pizza_id])
                                 .with_pizza_size(params[:pizza_size])
                                 .first_or_initialize
    ordered_pizza.quantity += 1
    ordered_pizza.save
    session[:profile_id] = current_order.ordering_profile.id
    render_cart
  end

  def decrease
    if ordered_pizza.quantity <= 1
      ordered_pizza.destroy
    else
      ordered_pizza.quantity -= 1
      ordered_pizza.save
    end
    render_cart
  end

  def increase
    ordered_pizza.quantity += 1
    ordered_pizza.save
    render_cart
  end

  private

  def render_cart
    respond_to do |format|
      format.html { redirect_to root_path }
      format.js { render 'shared/cart', layout: false }
    end
  end

  def ordered_pizza
    @ordered_pizza ||= OrderedPizza.find(params[:ordered_pizza_id])
  end
end
