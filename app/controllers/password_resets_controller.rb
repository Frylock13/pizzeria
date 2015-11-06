class PasswordResetsController < ApplicationController
  before_action :main_menu_link
  helper_method :user

  def new
    @password_reset = PasswordReset.new
  end

  def create
    @password_reset = PasswordReset.new(password_reset_params)
    return render :new, change: :new_password_reset, layout: !request.xhr? unless @password_reset.valid?
    user = User.find_by(email: @password_reset.email)
    if user.deliver_reset_password_instructions!
      redirect_to new_password_reset_path, success: 'Письмо для восстановления пароля отправлено на почту'
    else
      if user.reset_password_email_sent_at > (5*60).seconds.ago.utc
        flash[:error] = 'Письмо отправлено совсем недавно: подождите 5 минут'
        render :new, change: :new_password_reset
      else
        flash[:error] = 'Не удается отправить письмо'
        render :new, change: :new_password_reset
      end
    end
  end

  def edit
    @token = params[:id]
    return not_authenticated if user.blank?
  end

  def update
    @token = params[:id]
    return not_authenticated if user.blank?
    if user.change_password!(user_params[:password])
      auto_login(user)
      redirect_to root_path, success: 'Вы успешно установили пароль'
    else
      flash[:error] = 'Не удается установить пароль'
      render :edit, change: "edit_user_#{user.id}"
    end
  end

  private

  def main_menu_link
    @main_menu_link = :auth
  end

  def user
    @user ||= User.load_from_reset_password_token(params[:id])
  end

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end

  def user_params
    params.require(:user).permit(:password)
  end
end
