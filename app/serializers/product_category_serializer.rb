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

class ProductCategorySerializer < ActiveModel::Serializer
  attributes :id, :name, :position

  has_many :products
end
