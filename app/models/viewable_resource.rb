# == Schema Information
#
# Table name: viewable_resources
#
#  id               :integer          not null, primary key
#  anchor           :string
#  meta_keywords    :string
#  meta_title       :string
#  page_annotation  :text
#  page_description :text
#  page_title       :string
#  viewable_id      :integer
#  viewable_type    :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class ViewableResource < ActiveRecord::Base
  belongs_to :viewable, polymorphic: true
end
