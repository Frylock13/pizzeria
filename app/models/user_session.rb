class UserSession
  include ActiveModel::Model

  attr_accessor :email, :password

  validates :email, presence: true
  validates :email, email: true, user_by_email: true, if: :email?
  validates :password, presence: true, length: { minimum: 3 }

  def email?
    email.present?
  end
end
