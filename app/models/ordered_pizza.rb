# == Schema Information
#
# Table name: ordered_pizzas
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  pizza_id   :integer
#  quantity   :integer          default(1)
#  pizza_size :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderedPizza < ActiveRecord::Base
  include PizzaSizes
  belongs_to :order
  belongs_to :pizza

  scope :for_pizza, -> (pizza_id) { where(pizza_id: pizza_id) }
end
