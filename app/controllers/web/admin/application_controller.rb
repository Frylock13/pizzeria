class Web::Admin::ApplicationController < Web::ApplicationController
  before_filter :require_admin

  private

  def require_admin
    forbidden unless current_user&.role&.admin?
  end
end
