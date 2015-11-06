class PasswordResetsController < ApplicationController
  before_action :main_menu_link

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
    user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if user.blank?
  end

  def update
    user = User.load_from_reset_password_token(params[:id])
    return not_authenticated if user.blank?

    if user.change_password!(params[:user][:password])
      auto_login(user)
      render json: { status: 'success' }
    else
      render json: { status: 'error' }, status: 422
    end
  end

  private

  def main_menu_link
    @main_menu_link = :auth
  end

  def password_reset_params
    params.require(:password_reset).permit(:email)
  end
end
