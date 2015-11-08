# == Schema Information
#
# Table name: call_requests
#
#  id         :integer          not null, primary key
#  profile_id :integer
#  wishes     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CallRequest < ActiveRecord::Base
  belongs_to :profile

  accepts_nested_attributes_for :profile
end
