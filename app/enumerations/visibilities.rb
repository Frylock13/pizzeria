module Visibilities
  extend Enumerize
  enumerize :visibility, in: { for_admin: 0, for_user: 1, for_all: 2 }, default: :for_admin, scope: true
end
