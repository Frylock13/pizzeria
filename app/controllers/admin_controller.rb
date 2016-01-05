class AdminController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  # private

  # def layout_resources
  #   [revision]
  # end
end
