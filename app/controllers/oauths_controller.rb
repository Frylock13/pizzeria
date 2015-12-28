class OauthsController < ApplicationController
  skip_before_filter :require_login

  def run
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if user = login_from(provider)
      redirect_to root_path, notice: "Успешно зашли через #{provider.titleize}"
    else
      if current_user.present?
        add_provider_to_user(provider)
        redirect_to root_path, notice: "Успешно подключили #{provider.titleize} к вашему аккаунту"
      else
        redirect_to register_path, notice: 'Для входа через соцсети вам нужно зарегистрироваться'
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
