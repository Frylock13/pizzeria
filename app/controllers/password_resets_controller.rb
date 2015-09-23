class PasswordResetsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    return render json: { status: 'error' } unless user.present?
    if user.deliver_reset_password_instructions!
      render json: { status: 'success' }
    else
      if user.reset_password_email_sent_at > (5*60).seconds.ago.utc
        render json: { status: 'error', message: '<b>Письмо уже отправлено</b><br/>Повторно отправить вы сможете через пару минут:' }, status: 422
      else
        render json: { status: 'error' }, status: 422
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
end
