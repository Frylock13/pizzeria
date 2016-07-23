class UserPassword
  include ActiveModel::Model

  attr_accessor :id, :user, :password

  validates :password, presence: true, length: { minimum: 3 }

  class << self
    def find(token)
      user = User.load_from_reset_password_token(token)
      UserPassword.new(id: token, user: user) if user.present?
    end
  end

  def update(attributes)
    @password = attributes[:password]
    return false unless valid?
    return false unless user.change_password!(password)
    true
  end

  def persisted?
    id.present?
  end
end
