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
  has_many :ordered_product_features, dependent: :destroy
  accepts_nested_attributes_for :ordered_product_features

  def feature_names
    return '' unless ordered_product_features.any?
    ordered_product_features.map{ |item| item.product_feature.name }.join(', ')
  end

  def price
    return 0 unless product.price
    product.price * quantity
  end
end
