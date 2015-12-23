# == Schema Information
#
# Table name: addresses
#
#  id            :integer          not null, primary key
#  owner_id      :integer
#  street        :string(50)
#  house         :string(10)
#  flat          :string(10)
#  floor         :string(10)
#  intercom_code :string(10)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  entrance      :string(10)
#  pickup        :boolean
#  city          :string(50)
#

class Address < ActiveRecord::Base
  belongs_to :owner, class_name: 'User'
  has_many :orders

  def to_s
    str = (pickup == true ? 'Самовывоз: ' : '')
    str += "#{city}, " if city.present?
    str += "#{street} #{house}"
    str += ", подъезд #{entrance}" if entrance.present?
    str += ", квартира #{flat}" if flat.present?
    str += ", #{floor}-й этаж" if floor.present?
    str += ", домофон #{intercom_code}" if intercom_code.present?
    str
  end
end
