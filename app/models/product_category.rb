# == Schema Information
#
# Table name: product_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductCategory < ActiveRecord::Base
  acts_as_list

  has_many :products, -> { order(name: :asc) }, dependent: :destroy

  validates :name, presence: true
end
