# == Schema Information
#
# Table name: ingredient_categories
#
#  id         :integer          not null, primary key
#  name       :string
#  position   :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe IngredientCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end