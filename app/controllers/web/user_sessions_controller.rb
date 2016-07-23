class Web::UserSessionsController < Web::ApplicationController
  before_filter :require_login, only: :destroy
  before_action :menu_key

  def new
    render locals: { user_session: UserSession.new }
  end

  def create
    user_session = UserSession.new(user_session_params)
    if save_resource(user_session)
      current_profile.update(email: current_user.email, owner_id: current_user.id)
      redirect_to :root, success: 'Вы успешно вошли в систему'
    else
      flash[:error] = 'Не удалось войти в систему'
      render :new, locals: { user_session: user_session }, change: :new_user_session
    end
  end

  def destroy
    if logout
      redirect_to :root, success: 'Вы успешно вышли из системы'
    else
      redirect_to :root, error: 'Не удалось выйти из системы'
    end
  end

  private

  def save_resource(user_session)
    return false unless user_session.valid?
    return true if login(user_session.email, user_session.password, _remember_me = true)
    user_session.errors.add(:password, 'неверный пароль')
    false
  end

  def menu_key
    @menu_key = :auth
  end

  def user_session_params
    params.require(:user_session).permit(:email, :password)
  end
end
