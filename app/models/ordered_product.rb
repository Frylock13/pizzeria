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
  has_many :product_features, through: :ordered_product_features, source: :product_feature
  accepts_nested_attributes_for :ordered_product_features
  delegate :name, to: :product, allow_nil: true, prefix: :product

  def feature_names
    return '' unless ordered_product_features.any?
    product_features.map{ |item| item.name }.join(', ')
  end

  def price
    (product.safe_price + (product_features.map{ |item| item.price }.sum || 0)) * quantity
  end
end
