# == Schema Information
#
# Table name: pizza_ingredients
#
#  id            :integer          not null, primary key
#  pizza_id      :integer
#  ingredient_id :integer
#  quantity      :integer          default(1)
#  core          :boolean          default(FALSE)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class PizzaIngredient < ActiveRecord::Base
  belongs_to :pizza
  belongs_to :ingredient
end
