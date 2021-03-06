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

class PizzaAttribute < ActiveRecord::Base
  include PizzaSizes
  belongs_to :pizza, touch: true
end
