class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def not_authenticated
    render 'user_sessions/new', layout: 'application'
    # redirect_to auth_path(p: request.original_url), alert: I18n.t('sessions.not_authenticated')
  end

  def require_admin
    forbidden unless current_user.role.try(:admin?)
  end

  def not_found
    redirect_to root_path, status: :not_found
  end

  def forbidden
    redirect_to root_path, status: :forbidden
  end
end
