# == Schema Information
#
# Table name: doughs
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Dough < ActiveRecord::Base
  has_many :dough_attributes, dependent: :destroy

  validates :name, presence: true

  accepts_nested_attributes_for :dough_attributes
end
