# == Schema Information
#
# Table name: attribute_values
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class AttributeValue < ActiveRecord::Base
  validates :name, presence: true
end
