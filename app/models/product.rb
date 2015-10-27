# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  name                :string
#  image               :string
#  description         :text
#  weight              :integer
#  price               :decimal(5, 2)
#  product_category_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Product < ActiveRecord::Base
  belongs_to :product_category
  enum visibility: [:for_admin, :for_user, :for_all]
  mount_uploader :image, ProductPhotoUploader

  validates :name, :product_category_id, presence: true
end
