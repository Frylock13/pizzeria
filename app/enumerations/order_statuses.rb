module OrderStatuses
  extend Enumerize
  enumerize :order_status,
            in: [:created, :booked, :accepted, :assembled, :delivered, :closed],
            default: :created
end
