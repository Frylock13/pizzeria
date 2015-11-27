# == Schema Information
#
# Table name: ordered_products
#
#  id         :integer          not null, primary key
#  order_id   :integer
#  product_id :integer
#  quantity   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class OrderedProduct < ActiveRecord::Base
  belongs_to :order
  belongs_to :product

  def price
    product.price * quantity
  end
end
