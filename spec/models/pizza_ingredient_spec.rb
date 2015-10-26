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

require 'rails_helper'

RSpec.describe PizzaIngredient, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
