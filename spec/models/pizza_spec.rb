# == Schema Information
#
# Table name: pizzas
#
#  id         :integer          not null, primary key
#  name       :string
#  image      :string
#  visibility :integer          default(0)
#  user_id    :integer
#  dough_id   :integer
#  parent_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Pizza, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
