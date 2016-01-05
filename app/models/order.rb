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
#

class Order < ActiveRecord::Base
  include OrderEnums
  belongs_to :address
  belongs_to :ordering_profile, class_name: 'Profile'
  belongs_to :receiving_profile, class_name: 'Profile'
  has_many :ordered_pizzas
  has_many :ordered_products
  accepts_nested_attributes_for :address
  accepts_nested_attributes_for :ordering_profile
  accepts_nested_attributes_for :receiving_profile
  delegate :first_name, :phone, to: :ordering_profile, allow_nil: true, prefix: :ordering
  delegate :first_name, :phone, to: :receiving_profile, allow_nil: true, prefix: :receiving

  def empty?
    return false if ordered_pizzas.any?
    return false if ordered_products.any?
    true
  end

  def price
    ordered_pizzas.map(&:price).sum + ordered_products.map(&:price).sum
  end

  def to_s
    "Заказ на сумму #{ActionController::Base.helpers.number_to_currency price, precision: 0}"
  end
end
