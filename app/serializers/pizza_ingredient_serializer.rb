class PizzaIngredientSerializer < ActiveModel::Serializer
  attributes :id, :pizza_id, :ingredient_id, :quantity, :core
end
