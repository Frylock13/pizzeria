class IngredientCategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :position

  has_many :ingredients
end
