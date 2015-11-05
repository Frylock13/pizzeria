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
end
