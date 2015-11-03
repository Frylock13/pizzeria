module Roles
  extend Enumerize
  enumerize :role, in: { user: 0, admin: 1 }, default: :user
end
