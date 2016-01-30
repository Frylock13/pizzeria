class OrderCreatingService
  attr_accessor :order

  def initialize(order)
    @order = order
  end

  def submit
    order.update(booked_on: Time.zone.now) unless order.booked_on?
    user = User.where(email: order.ordering_profile.email)
               .first_or_initialize(password: SecureRandom.hex(16))
    deliver_email = true if user.new_record?
    user.bonus_points += (order.price * 0.1).floor if order.payment_method == :cash
    user.bonus_points -= order.price if order.payment_method == :bonus_points
    user.save!
    user.deliver_reset_password_instructions! if deliver_email == true
    SmsWorker.perform_async(ENV['SMSAERO_PHONE'], 'Оформлен заказ на vpzven.ru')
  end
end
