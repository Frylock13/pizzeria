class PizzaRecalculatingService
  attr_accessor :pizza, :parent

  def initialize(pizza)
    @pizza = pizza
    @parent = pizza.parent
  end

  def recalculate
    if parent.present?
      PizzaSizes.pizza_size.values.each do |pizza_size|
        next unless parent.price(pizza_size).present?
        dprice = parent.price(pizza_size) - parent.price(pizza_size, fair: true)
        dprice += parent.pizza_ingredients.based
                        .where.not(ingredient_id: pizza.pizza_ingredients.map(&:ingredient_id))
                        .map { |item| item.price(pizza_size) }.sum
        pizza.pizza_attributes.find { |r| r.pizza_size == pizza_size }
             .assign_attributes(price: pizza.price(pizza_size, fair: true) + dprice)
      end
    else
      PizzaSizes.pizza_size.values.each do |pizza_size|
        pizza.pizza_attributes.find { |r| r.pizza_size == pizza_size }
             .assign_attributes(price: pizza.price(pizza_size, fair: true))
      end
    end
    PizzaSizes.pizza_size.values.each do |pizza_size|
      if parent.weight(pizza_size).present?
        pizza.pizza_attributes.find { |r| r.pizza_size == pizza_size }
             .assign_attributes(weight: pizza.weight(pizza_size, fair: true))
      end
    end
  end
end
