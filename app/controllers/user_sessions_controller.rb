class UserSessionsController < ApplicationController
  before_filter :require_login, only: :destroy
  before_action :main_menu_link

  def new
    @user_session = UserSession.new
    render :new if stale? [@user_session] | layout_resources
  end

  def create
    @user_session = UserSession.new(user_session_params)
    return render :new, change: :new_user_session, layout: !request.xhr? unless @user_session.valid?
    if login(@user_session.email, @user_session.password, remember_me = true)
      current_profile.update(email: current_user.email, owner_id: current_user.id)
      redirect_to root_path, success: 'Вы успешно вошли в систему'
    else
      flash[:error] = 'Не удалось войти в систему'
      render :new, change: :new_user_session
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'Вы успешно вышли из системы'
  end

  private

  def main_menu_link
    @main_menu_link = :auth
  end

  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
