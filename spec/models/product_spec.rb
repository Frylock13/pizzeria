# == Schema Information
#
# Table name: products
#
#  id                  :integer          not null, primary key
#  name                :string
#  image               :string
#  description         :text
#  weight              :integer
#  price               :decimal(15, 2)
#  product_category_id :integer
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  visibility          :integer          default(0)
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
