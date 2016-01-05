class PasswordReset < ActiveForm
  attribute :email

  validates :email, presence: true, email: true, user_by_email: true

  private

  def persist_data
    user = User.find_by(email: email)
    return true if user.deliver_reset_password_instructions!
    if user.reset_password_email_sent_at > (5 * 60).seconds.ago.utc
      errors.add(:email, 'письмо отправлено совсем недавно, попробуйте через 5 минут')
    end
    false
  end
end
