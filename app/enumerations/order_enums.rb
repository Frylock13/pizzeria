module OrderEnums
  extend Enumerize
  extend ActiveModel::Naming
  enumerize :payment_method, in: [:cash, :bonus_points], default: :cash
  enumerize :status, in: [:created, :booked, :accepted, :cooking, :assembled,
                          :delivered, :closed, :canceled],
                     default: :created, scope: true
end
