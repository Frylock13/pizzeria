# == Schema Information
#
# Table name: doughs
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Dough < ActiveRecord::Base
  has_many :dough_attributes, dependent: :destroy
  has_many :pizzas, dependent: :destroy

  validates :name, presence: true
  accepts_nested_attributes_for :dough_attributes

  def price(pizza_size)
    dough_attributes.with_pizza_size(pizza_size).first.price
  end

  def weight(pizza_size)
    dough_attributes.with_pizza_size(pizza_size).first.weight
  end
end
