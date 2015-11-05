class AdminController < ApplicationController
  before_filter :require_admin
  layout 'admin'

  def dashboard
    render :dashboard if stale? [:admin_dashboard] | layout_resources
  end

  private

  def layout_resources
    [revision]
  end
end
