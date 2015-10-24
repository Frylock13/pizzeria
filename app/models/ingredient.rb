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

  validates :name, presence: true
end
