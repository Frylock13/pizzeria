# == Schema Information
#
# Table name: ingredients
#
#  id                     :integer          not null, primary key
#  name                   :string
#  ingredient_category_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  image                  :string
#  layer                  :integer
#

class IngredientSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :ingredient_attributes
end
