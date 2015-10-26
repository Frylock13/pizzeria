# == Schema Information
#
# Table name: dough_attributes
#
#  id         :integer          not null, primary key
#  dough_id   :integer
#  pizza_size :integer
#  price      :decimal(5, 2)
#  weight     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe DoughAttribute, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
