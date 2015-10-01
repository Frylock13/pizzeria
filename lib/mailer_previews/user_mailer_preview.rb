class UserMailerPreview < ActionMailer::Preview
  def reset_password
    UserMailer.reset_password(user)
  end

  private

  def user
    @user ||= User.first
  end
end
