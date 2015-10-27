class AdminController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  def dashboard
    render :dashboard if stale? :admin_dashboard
  end
end
