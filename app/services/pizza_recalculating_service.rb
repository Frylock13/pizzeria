class PizzaRecalculatingService
  attr_accessor :pizza, :parent

  def initialize(pizza)
    @pizza = pizza
    @parent = pizza.parent
  end

  def recalculate
    if parent.present?
      PizzaSizes.pizza_size.values.each do |pizza_size|
        dprice = parent.price(pizza_size) - parent.price(pizza_size, fair: true)
        dprice += parent.pizza_ingredients.based
                        .where.not(ingredient_id: pizza.pizza_ingredients.map{ |item| item.ingredient_id })
                        .map{ |item| item.price(pizza_size) }.sum
        pizza.pizza_attributes.select{ |r| r.pizza_size == pizza_size }.first
             .assign_attributes(price: pizza.price(pizza_size, fair: true) + dprice)
      end
    else
      PizzaSizes.pizza_size.values.each do |pizza_size|
        pizza.pizza_attributes.select{ |r| r.pizza_size == pizza_size }.first
             .assign_attributes(price: pizza.price(pizza_size, fair: true))
      end
    end
    PizzaSizes.pizza_size.values.each do |pizza_size|
      pizza.pizza_attributes.select{ |r| r.pizza_size == pizza_size }.first
           .assign_attributes(weight: pizza.weight(pizza_size, fair: true))
    end
  end
end
