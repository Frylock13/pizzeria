class UserSession < ActiveForm
  attribute :email
  attribute :password

  validates :email, presence: true, email: true, user_by_email: true
  validates :password, presence: true, length: { minimum: 3 }

  private

  def persist_data
    true
  end
end
