class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :pages

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

  private

  def pages
    @pages ||= Page.all.includes(:viewable_resource).order(:slug)
  end

  def layout_resources
    [current_profile, current_user_etag, pages, revision]
  end

  def profile_from_session
    Profile.find_by(id: session[:profile_id]) if session[:profile_id]
  end

  def profile_for_user
    return nil unless current_user.present?
    profile = current_user.profiles.owned_by_user(current_user.id).last
    profile = Profile.create(email: current_user.email, owner_id: current_user.id) if profile.nil?
    session[:profile_id] = profile.id
    profile
  end

  def profile_for_guest
    profile = Profile.create
    session[:profile_id] = profile.id
    profile
  end

  def current_profile
    @current_profile ||= profile_from_session || profile_for_user || profile_for_guest
    logger.debug @current_profile.to_json
    @current_profile
  end

  def current_user_etag
    current_user || :guest
  end

  def revision
    @revision ||= { last_modified: File.atime("#{Rails.root}/REVISION").utc, etag: :revision }
  end
end
