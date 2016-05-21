class Web::Admin::Orders::OrderedPizzas::ApplicationController < Web::Admin::Orders::ApplicationController
  helper_method :ordered_pizza

  private

  def ordered_pizza
    @ordered_pizza ||= OrderedPizza.find(params[:ordered_pizza_id])
  end
end
