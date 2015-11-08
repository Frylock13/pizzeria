# == Schema Information
#
# Table name: pizza_ingredients
#
#  id            :integer          not null, primary key
#  pizza_id      :integer
#  ingredient_id :integer
#  quantity      :integer          default(1)
#  base          :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PizzaIngredientSerializer < ActiveModel::Serializer
  attributes :id, :pizza_id, :ingredient_id, :quantity, :base
end
