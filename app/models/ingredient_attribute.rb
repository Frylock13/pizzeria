# == Schema Information
#
# Table name: ingredient_attributes
#
#  id            :integer          not null, primary key
#  ingredient_id :integer
#  pizza_size    :integer
#  price         :decimal(5, 2)
#  weight        :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class IngredientAttribute < ActiveRecord::Base
  include Sizeable
  belongs_to :ingredient
end
