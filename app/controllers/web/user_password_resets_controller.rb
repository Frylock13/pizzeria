class Web::UserPasswordResetsController < Web::ApplicationController
  before_action :menu_key

  def new
    render locals: { user_password_reset: UserPasswordReset.new }
  end

  def create
    user_password_reset = UserPasswordReset.new(user_password_reset_params)
    if user_password_reset.save
      redirect_to user_password_reset
    else
      flash[:error] = 'Не удается отправить письмо'
      render :new, locals: { user_password_reset: user_password_reset },
                   change: :new_password_reset, layout: !request.xhr?
    end
  end

  def show
  end

  private

  def menu_key
    @menu_key = :auth
  end

  def user_password_reset_params
    params.require(:user_password_reset).permit(:email)
  end
end
