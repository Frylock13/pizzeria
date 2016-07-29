class OrderCreatingService
  attr_accessor :order
  attr_accessor :user

  def initialize(order)
    @order = order
  end

  def submit
    order.update(booked_on: Time.zone.now) unless order.booked_on?
    SmsCService.new(ENV['APP_PHONE'], "Оформлен #{order.to_s}").send
    # SmsWorker.perform_async ENV['APP_PHONE'], "Оформлен #{order.to_s}"
    @user = User.where(email: order.ordering_profile.email)
                .first_or_initialize(password: SecureRandom.hex(16))
    user.bonus_points += (order.price * 0.1).floor if order.payment_method == :cash
    user.bonus_points -= order.price if order.payment_method == :bonus_points
    user.save!
    # user.deliver_reset_password_instructions! if user.new_record?
  end
end
