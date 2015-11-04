# == Schema Information
#
# Table name: product_features
#
#  id               :integer          not null, primary key
#  product_id       :integer
#  feature_id       :integer
#  feature_value_id :integer
#  price            :decimal(15, 2)
#  weight           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ProductFeature < ActiveRecord::Base
  belongs_to :product
  belongs_to :feature
  belongs_to :feature_value

  validates :product_id, :feature_id, :feature_value_id, presence: true
end
