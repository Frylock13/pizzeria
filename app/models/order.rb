# == Schema Information
#
# Table name: orders
#
#  id                   :integer          not null, primary key
#  address_id           :integer
#  status               :string
#  wishes               :text
#  receiving_profile_id :integer
#  ordering_profile_id  :integer
#  payment_method       :string
#  booked_on            :datetime
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  discount_card_number :string
#  discount_in_percents :decimal(5, 2)
#

class Order < ActiveRecord::Base
  include OrderEnums
  belongs_to :address
  belongs_to :ordering_profile, class_name: 'Profile'
  belongs_to :receiving_profile, class_name: 'Profile'
  has_many :ordered_pizzas, dependent: :destroy
  has_many :ordered_products, dependent: :destroy
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :ordering_profile
  accepts_nested_attributes_for :receiving_profile
  delegate :first_name, :phone, to: :ordering_profile, allow_nil: true, prefix: :ordering
  delegate :first_name, :phone, to: :receiving_profile, allow_nil: true, prefix: :receiving

  scope :with_profiles, (lambda do |profile_ids|
    where('receiving_profile_id IN (?) or ordering_profile_id IN (?)', profile_ids, profile_ids)
  end)

  def empty?
    return false if ordered_pizzas.any?
    return false if ordered_products.any?
    true
  end

  def price
    ordered_pizzas.map(&:price).sum + ordered_products.map(&:price).sum
  end

  def discounted_sum
    return price unless discount_in_percents
    price * (100 - discount_in_percents) / 100
  end

  def to_s
    "Заказ на сумму #{ActionController::Base.helpers.number_to_currency price, precision: 0}"
  end
end
