# == Schema Information
#
# Table name: ingredients
#
#  id                     :integer          not null, primary key
#  name                   :string
#  ingredient_category_id :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class Ingredient < ActiveRecord::Base
  belongs_to :ingredient_category
  has_many :ingredient_attributes, dependent: :destroy

  validates :name, :ingredient_category_id, presence: true

  accepts_nested_attributes_for :ingredient_attributes
end
