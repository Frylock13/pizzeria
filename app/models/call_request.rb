# == Schema Information
#
# Table name: call_requests
#
#  id                   :integer          not null, primary key
#  ordering_profile_id  :integer
#  wishes               :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  receiving_profile_id :integer
#

class CallRequest < ActiveRecord::Base
  belongs_to :ordering_profile, class_name: 'Profile'
  belongs_to :receiving_profile, class_name: 'Profile'

  delegate :first_name, :phone, to: :ordering_profile, allow_nil: true, prefix: :ordering
  delegate :first_name, :phone, to: :receiving_profile, allow_nil: true, prefix: :receiving
end
