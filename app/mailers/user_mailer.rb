class UserMailer < BaseMailer
  def become_admin(user)
    @user = user
    mail to: user.email, subject: 'Вам присвоены права администратора'
  end

  def register(user)
    @user = user
    mail to: user.email, subject: 'Добро пожаловать!'
  end

  def reset_password(user)
    @url = edit_password_reset_url(user.reset_password_token)
    mail to: user.email, subject: 'Восстановление пароля'
  end
end
