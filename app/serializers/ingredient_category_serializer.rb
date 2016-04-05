# == Schema Information
#
# Table name: ingredient_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class IngredientCategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :position, :ingredients

  def ingredients
    if scope&.role&.admin?
      object.ingredients
    else
      object.ingredients.with_visibility(:for_all)
    end
  end
end
