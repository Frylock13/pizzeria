class UserSessionsController < ApplicationController
  before_filter :require_login, only: :destroy
  before_action :menu_key

  def new
    user_session = UserSession.new
    render locals: { user_session: user_session }
  end

  def create
    user_session = UserSession.new(user_session_params)
    unless user_session.valid?
      return render :new, locals: { user_session: user_session },
                    change: :new_user_session, layout: !request.xhr?
    end
    if login(user_session.email, user_session.password, remember_me = true)
      current_profile.update(email: current_user.email, owner_id: current_user.id)
      redirect_to root_path, success: 'Вы успешно вошли в систему'
    else
      flash[:error] = 'Не удалось войти в систему'
      render :new, locals: { user_session: user_session }, change: :new_user_session
    end
  end

  def destroy
    logout
    redirect_to root_path, success: 'Вы успешно вышли из системы'
  end

  private

  def menu_key
    @menu_key = :auth
  end

  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
