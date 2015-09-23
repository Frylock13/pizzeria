class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def require_admin
    forbidden unless current_user.admin?
  end

  def not_found
    redirect_to root_path, status: :not_found
  end

  def forbidden
    redirect_to root_path, status: :forbidden
  end
end
