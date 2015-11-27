# == Schema Information
#
# Table name: profiles
#
#  id         :integer          not null, primary key
#  first_name :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  phone      :string
#  email      :string
#  owner_id   :integer
#

class Profile < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  belongs_to :user, foreign_key: :email, primary_key: :email
  has_many :call_requests
  has_many :ordering_orders, class_name: 'Order', foreign_key: :ordering_profile_id
  has_many :owned_pizzas, class_name: 'Pizza', foreign_key: :owner_id
  has_many :receiving_orders, class_name: 'Order', foreign_key: :receiving_profile_id

  scope :owned_by_user, -> (user_id) { where(owner_id: user_id) }

  def to_s
    str = first_name || 'Без имени'
    str += " #{phone}" if phone.present?
    str += " (#{email})" if email.present?
    str
  end

  # def orders
  #   ordering_orders | receiving_orders
  # end
end
