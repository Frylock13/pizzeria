# == Schema Information
#
# Table name: attributes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Attribute < ActiveRecord::Base
  validates :name, presence: true
end
