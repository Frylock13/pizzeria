# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  name                :string
#  image               :string
#  description         :text
#  weight              :integer
#  price               :decimal(15, 2)
#  product_category_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  visibility          :integer          default(0)
#

class Product < ActiveRecord::Base
  include Visibilities
  belongs_to :product_category, touch: true
  has_many :features, through: :product_features, source: :feature
  has_many :product_features
  mount_uploader :image, ProductPhotoUploader

  validates :name, :product_category_id, presence: true
end
