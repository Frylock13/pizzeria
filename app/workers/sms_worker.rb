class SmsWorker
  include Sidekiq::Worker

  def perform(phone, text)
    return puts text if Rails.env.development?
    SmsService.new(phone, text).send
  end
end
