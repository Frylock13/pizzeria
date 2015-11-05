# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Page < ActiveRecord::Base
  include Viewable
end
