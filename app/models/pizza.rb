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

class Pizza < ActiveRecord::Base
  belongs_to :dough
  belongs_to :parent, class_name: 'Pizza'
  belongs_to :user
  has_many :pizza_attributes, dependent: :destroy
  enum visibility: [:for_admin, :for_user, :for_all]

  validates :name, presence: true
  accepts_nested_attributes_for :pizza_attributes
end
