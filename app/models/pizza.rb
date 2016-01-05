# == Schema Information
#
# Table name: pizzas
#
#  id                :integer          not null, primary key
#  name              :string
#  image             :string
#  visibility        :integer          default(0)
#  owner_id          :integer
#  dough_id          :integer
#  parent_id         :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  hot               :boolean
#  pizza_category_id :integer
#

class Pizza < ActiveRecord::Base
  include Visibilities
  belongs_to :dough
  belongs_to :owner, class_name: 'Profile'
  belongs_to :parent, class_name: 'Pizza'
  belongs_to :pizza_category, touch: true
  has_many :ingredients, through: :pizza_ingredients, source: :ingredient
  has_many :ordered_pizzas, dependent: :destroy
  has_many :pizza_attributes, dependent: :destroy
  has_many :pizza_ingredients, dependent: :destroy
  mount_uploader :image, ProductPhotoUploader

  validates :name, :pizza_category_id, presence: true
  accepts_nested_attributes_for :owner
  accepts_nested_attributes_for :pizza_attributes
  accepts_nested_attributes_for :pizza_ingredients, allow_destroy: true

  scope :standard, -> { where(parent_id: nil) }

  def price(pizza_size, fair: false)
    return pizza_attributes.with_pizza_size(pizza_size).first.price if fair == false
    return nil unless dough.present?
    dough.price(pizza_size) + pizza_ingredients.map { |item| item.price(pizza_size) }.sum
  end

  def weight(pizza_size, fair: false)
    return pizza_attributes.with_pizza_size(pizza_size).first.weight if fair == false
    return nil unless dough.present?
    dough.weight(pizza_size) + pizza_ingredients.map { |item| item.weight(pizza_size) }.sum
  end
end
