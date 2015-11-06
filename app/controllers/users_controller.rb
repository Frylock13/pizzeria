class UsersController < ApplicationController
  def new
    @main_menu_link = :auth
    @user = User.new
    render :new if stale? [@user] | layout_resources
  end

  def create
    @main_menu_link = :auth
    @user = User.new(user_params)
    if @user.save
      auto_login(@user, should_remember = true)
      current_profile.update(email: current_user.email, owner_id: current_user.id)
      redirect_to root_path, success: 'Вы успешно зарегистрированы'
    else
      render :new, change: :new_user, layout: !request.xhr?
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
