module Visibilities
  extend Enumerize
  enumerize :visibility, in: [:for_admin, :for_user, :for_all]
end
