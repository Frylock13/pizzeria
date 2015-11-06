# == Schema Information
#
# Table name: ordered_product_features
#
#  id                 :integer          not null, primary key
#  ordered_product_id :integer
#  product_feature_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class OrderedProductFeature < ActiveRecord::Base
  belongs_to :ordered_product
  belongs_to :product_feature
end
