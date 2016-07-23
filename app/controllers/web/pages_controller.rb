# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Web::PagesController < Web::ApplicationController
  def show
    @menu_key = "page-#{params[:id]}"
    @page = Page.find(params[:id])
  end
end
