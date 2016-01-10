# == Schema Information
#
# Table name: ordered_pizzas
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  pizza_id   :integer
#  quantity   :integer          default(0)
#  pizza_size :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderedPizza < ActiveRecord::Base
  include PizzaSizes
  belongs_to :order
  belongs_to :pizza
  delegate :name, :pizza_ingredients, to: :pizza, allow_nil: true

  scope :for_pizza, -> (pizza_id) { where(pizza_id: pizza_id) }

  def price
    (pizza.price(pizza_size) || 0) * quantity
  end
end
