# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Feature < ActiveRecord::Base
  has_many :product_features

  validates :name, presence: true
end
