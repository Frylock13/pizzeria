require 'digest/md5'
class SmsCService
  attr_accessor :phone, :text

  def initialize(phone, text)
    @phone = phone
    @text = text
  end

  def send
    url = "#{ENV['SMSC_LINK']}?#{URI.encode_www_form(hash)}"
    URI.parse(url).read
  end

  def hash
    {
      login: ENV['SMSC_LOGIN'],
      psw: Digest::MD5.hexdigest(ENV['SMSC_PASSWORD']),
      phones: phone,
      mes: text,
      sender: ENV['SMSC_FROM'],
      charset: 'utf-8'
    }
  end
end
