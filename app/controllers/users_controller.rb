class UsersController < ApplicationController
  before_filter :require_login, only: :update

  def create
    user = User.new(user_params)
    if user.save
      auto_login(user, should_remember=true)
      render json: { status: 'success' }
    else
      if user.errors.any?
        render json: { status: 'error', errors: user.errors }
      else
        render json: { status: 'error' }, status: 422
      end
    end
  end

  def update
    if user.update_attributes(user_params)
      render json: user
    else
      render json: { error: true }, status: 422
    end
  end

  private

  def user
    @user ||= User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
