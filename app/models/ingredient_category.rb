# == Schema Information
#
# Table name: ingredient_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class IngredientCategory < ActiveRecord::Base
  acts_as_list

  has_many :ingredients, -> { order(name: :asc) }, dependent: :destroy
end
