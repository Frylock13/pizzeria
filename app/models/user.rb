# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string
#  salt                            :string
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  role                            :integer          default(0)
#  bonus_points                    :decimal(15, 2)   default(0.0)
#

class User < ActiveRecord::Base
  include Roles
  has_many :owned_addresses, class_name: 'Address', foreign_key: :owner_id
  has_many :owned_profiles, class_name: 'Profile', foreign_key: :owner_id
  has_many :profiles, foreign_key: :email, primary_key: :email
  has_many :owned_pizzas, through: :profiles, source: :owned_pizzas

  authenticates_with_sorcery!

  validates :email, presence: true, email: true, uniqueness: true, on: :create
  validates :password, presence: true, length: { minimum: 3 }, on: :create
end
