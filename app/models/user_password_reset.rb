class UserPasswordReset
  include ActiveModel::Model

  attr_accessor :id, :email

  validates :email, presence: true, email: true, user_by_email: true

  def save
    return false unless valid?
    if user.deliver_reset_password_instructions!
      @id = user.id
      true
    else
      collect_errors
      false
    end
  end

  def persisted?
    id.present?
  end

  private

  def collect_errors
    if user.reset_password_email_sent_at > (5 * 60).seconds.ago.utc
      errors.add(:email, 'письмо отправлено совсем недавно, попробуйте через 5 минут')
    end
  end

  def user
    @user ||= User.find_by(email: email)
  end
end
