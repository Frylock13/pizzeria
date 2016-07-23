class Web::UserPasswordsController < Web::ApplicationController
  before_action :menu_key

  def edit
    render locals: { user_password: user_password }
  end

  def update
    if user_password.update(user_password_params)
      auto_login(user_password.user)
      current_profile.update(email: current_user.email, owner_id: current_user.id)
      redirect_to :root, success: 'Вы успешно установили пароль'
    else
      flash[:error] = 'Не удается установить пароль'
      render :edit, locals: { user_password: user_password }
    end
  end

  private

  def user_password
    @user_password ||= UserPassword.find(params[:id])
  end

  def menu_key
    @menu_key = :auth
  end

  def user_password_params
    params.require(:user_password).permit(:password)
  end
end
