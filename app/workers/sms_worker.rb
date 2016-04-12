class SmsWorker
  include Sidekiq::Worker

  def perform(phone, text)
    return logger.debug { text } if Rails.env.development?
    SmsCService.new(phone, text).send
  end
end
