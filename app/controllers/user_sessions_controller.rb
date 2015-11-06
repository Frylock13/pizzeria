class UserSessionsController < ApplicationController
  before_filter :require_login, only: :destroy

  def new
    @main_menu_link = :auth
    @user_session = UserSession.new
  end

  def create
    @main_menu_link = :auth
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      if login(@user_session.email, @user_session.password, remember_me = true)
        redirect_to root_path, success: 'Вы успешно вошли в систему'
      else
        flash[:error] = 'Не удалось войти в систему'
        render :new, change: :new_user_session
      end
    else
      render :new, change: :new_user_session, layout: !request.xhr?
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'Вы успешно вышли из системы'
  end

  private

  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
