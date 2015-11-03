# == Schema Information
#
# Table name: pizzas
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  visibility :integer          default(0)
#  user_id    :integer
#  dough_id   :integer
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pizza < ActiveRecord::Base
  include Visibilities
  belongs_to :dough
  belongs_to :parent, class_name: 'Pizza'
  belongs_to :user
  has_many :ingredients, through: :pizza_ingredients, source: :ingredient
  has_many :pizza_attributes, dependent: :destroy
  has_many :pizza_ingredients, dependent: :destroy
  mount_uploader :image, ProductPhotoUploader

  validates :name, presence: true
  accepts_nested_attributes_for :pizza_attributes
  accepts_nested_attributes_for :pizza_ingredients, allow_destroy: true
end
