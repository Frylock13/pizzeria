# == Schema Information
#
# Table name: product_features
#
#  id               :integer          not null, primary key
#  product_id       :integer
#  feature_id       :integer
#  feature_value_id :integer
#  price            :decimal(5, 2)
#  weight           :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

require 'rails_helper'

RSpec.describe ProductFeature, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
