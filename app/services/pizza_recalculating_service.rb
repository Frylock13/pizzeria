class PizzaRecalculatingService
  attr_accessor :pizza, :parent

  def initialize(pizza)
    @pizza = pizza
    @parent = pizza.parent
  end

  def recalculate
    if parent.present?
      PizzaSizes.pizza_size.values.each do |pizza_size|
        dprice = parent.pizza_attributes.with_pizza_size(pizza_size).first.price - parent.price(pizza_size)
        dweight = parent.pizza_attributes.with_pizza_size(pizza_size).first.weight - parent.weight(pizza_size)
        dprice += parent.pizza_ingredients.based
                        .where.not(ingredient_id: pizza.pizza_ingredients.map{ |item| item.ingredient_id })
                        .map{ |item| item.price(pizza_size) }.sum
        dweight += parent.pizza_ingredients.based
                         .where.not(ingredient_id: pizza.pizza_ingredients.map{ |item| item.ingredient_id })
                         .map{ |item| item.weight(pizza_size) }.sum
        pizza.pizza_attributes.select{ |r| r.pizza_size == pizza_size }.first
          .assign_attributes(price: dprice + pizza.price(pizza_size), weight: dweight + pizza.weight(pizza_size))
      end
    else
      PizzaSizes.pizza_size.values.each do |pizza_size|
        pizza.pizza_attributes.select{ |r| r.pizza_size == pizza_size }.first
          .assign_attributes(price: pizza.price(pizza_size), weight: pizza.weight(pizza_size))
      end
    end
  end
end
