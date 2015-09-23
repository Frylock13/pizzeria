class UserSessionsController < ApplicationController
  before_filter :require_login, only: :destroy

  def new
  end

  def create
    if login(user_params[:email], user_params[:password])
      render json: { status: 'success' }
    else
      render json: { status: 'error' }
    end
  end

  def destroy
    logout
    redirect_to login_path
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
