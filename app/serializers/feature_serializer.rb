# == Schema Information
#
# Table name: features
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FeatureSerializer < ActiveModel::Serializer
  attributes :id, :name
end
