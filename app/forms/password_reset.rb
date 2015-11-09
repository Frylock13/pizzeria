class PasswordReset < ActiveForm
  RECORDS = %W(password_reset)

  attribute :email
  attribute :password_reset

  validates :email, presence: true, email: true, user_by_email: true

  def build
    self.email = password_reset.email
  end

  private

  def persist_data
    true
  end
end
