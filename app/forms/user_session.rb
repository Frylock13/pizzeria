class UserSession < ActiveData
  RECORDS = %W(user_session)

  attribute :email
  attribute :password
  attribute :user_session

  validates :email, presence: true,
            format: { with: Regexp.new('\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z', true) }
  validates :password, presence: true, length: { minimum: 3 }

  def build
    self.email = user_session.email
    self.password = user_session.password
  end

  private

  def persist_data
    true
  end
end