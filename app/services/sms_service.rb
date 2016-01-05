require 'digest/md5'
class SmsService
  attr_accessor :phone, :text

  def initialize(phone, text)
    @phone = phone
    @text = text
  end

  def send
    params = "?user=#{hash[:user]}&password=#{hash[:password]}&to=#{hash[:to]}&text=#{hash[:text]}&from=#{hash[:from]}"
    url = ENV['SMSAERO_LINK'] + params
    puts URI.parse(url).read
  end

  def hash
    {
      user: ENV['SMSAERO_LOGIN'],
      password: Digest::MD5.hexdigest(ENV['SMSAERO_PWD']),
      to: phone,
      text: URI.encode(text),
      from: ENV['SMSAERO_FROM']
    }
  end
end
