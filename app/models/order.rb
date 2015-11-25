# == Schema Information
#
# Table name: orders
#
#  id                   :integer          not null, primary key
#  address_id           :integer
#  status               :integer
#  wishes               :text
#  receiving_profile_id :integer
#  ordering_profile_id  :integer
#  payment_method       :integer
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
end
