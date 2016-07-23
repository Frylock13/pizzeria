class Web::OauthsController < Web::ApplicationController
  skip_before_filter :require_login
  before_filter :require_login, only: :index

  def index
    @menu_key = :oauth
    @authentications = current_user.authentications
  end

  def run
    login_at(auth_params[:provider])
  end

  def callback
    provider = auth_params[:provider]
    if login_from(provider)
      redirect_to :root, notice: "Успешно зашли через #{provider.titleize}"
    else
      if current_user.present?
        add_provider_to_user(provider)
        redirect_to :root, notice: "Успешно подключили #{provider.titleize} к вашему аккаунту"
      else
        redirect_to :register, notice: 'Для входа через соцсети вам нужно зарегистрироваться'
      end
    end
  end

  private

  def auth_params
    params.permit(:code, :provider)
  end
end
