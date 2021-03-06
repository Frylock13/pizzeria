# == Schema Information
#
# Table name: ingredient_attributes
#
#  id            :integer          not null, primary key
#  ingredient_id :integer
#  pizza_size    :integer
#  price         :decimal(15, 2)
#  weight        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class IngredientAttribute < ActiveRecord::Base
  include PizzaSizes
  belongs_to :ingredient, touch: true
end
