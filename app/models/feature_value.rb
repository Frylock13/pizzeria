# == Schema Information
#
# Table name: feature_values
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FeatureValue < ActiveRecord::Base
  has_many :product_features

  validates :name, presence: true
end
