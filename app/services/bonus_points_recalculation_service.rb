class BonusPointsRecalculationService
  attr_accessor :order, :old_price

  def initialize(order, old_price)
    @order = Order.find(order.id)
    @old_price = old_price
  end

  def recalculate
    return unless order.payment_method.bonus_points?
    bonus_points = order.ordering_profile.owner.bonus_points + old_price - order.price
    order.ordering_profile.owner.update(bonus_points: bonus_points)
  end
end
