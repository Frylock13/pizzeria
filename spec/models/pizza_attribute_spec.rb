# == Schema Information
#
# Table name: pizza_attributes
#
#  id         :integer          not null, primary key
#  pizza_id   :integer
#  pizza_size :integer
#  price      :decimal(15, 2)
#  weight     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe PizzaAttribute, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
