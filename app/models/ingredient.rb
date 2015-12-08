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

class Ingredient < ActiveRecord::Base
  belongs_to :ingredient_category, touch: true
  has_many :ingredient_attributes, dependent: :destroy
  has_many :pizza_ingredients, dependent: :destroy
  has_many :pizzas, through: :pizza_ingredients, source: :pizza
  mount_uploader :image, ProductPhotoUploader

  validates :name, :ingredient_category_id, presence: true

  accepts_nested_attributes_for :ingredient_attributes

  def price(pizza_size)
    ingredient_attributes.with_pizza_size(pizza_size).first.price
  end

  def weight(pizza_size)
    ingredient_attributes.with_pizza_size(pizza_size).first.weight
  end
end
