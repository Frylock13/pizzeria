class AdminController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  def dashboard
  end
end
