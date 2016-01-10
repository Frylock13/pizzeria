# == Schema Information
#
# Table name: users
#
#  id                              :integer          not null, primary key
#  email                           :string           not null
#  crypted_password                :string
#  salt                            :string
#  created_at                      :datetime
#  updated_at                      :datetime
#  remember_me_token               :string
#  remember_me_token_expires_at    :datetime
#  reset_password_token            :string
#  reset_password_token_expires_at :datetime
#  reset_password_email_sent_at    :datetime
#  role                            :integer          default(0)
#  bonus_points                    :decimal(15, 2)   default(0.0)
#

class UsersController < ApplicationController
  def new
    @menu_key = :auth
    @user = User.new
    # render :new if stale? [@user] | layout_resources
  end

  def create
    @menu_key = :auth
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
