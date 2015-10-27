# == Schema Information
#
# Table name: dough_attributes
#
#  id         :integer          not null, primary key
#  dough_id   :integer
#  pizza_size :integer
#  price      :decimal(15, 2)
#  weight     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DoughAttribute < ActiveRecord::Base
  include Sizeable
  belongs_to :dough
end
