class SmsWorker
  include Sidekiq::Worker

  def perform(phone, text)
    return logger.debug { text } if Rails.env.development?
    SmsService.new(phone, text).send
  end
end
