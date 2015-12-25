# == Schema Information
#
# Table name: pizza_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PizzaCategory < ActiveRecord::Base
  acts_as_list

  has_many :pizzas, -> { order(name: :asc) }, dependent: :destroy

  validates :name, presence: true
end
