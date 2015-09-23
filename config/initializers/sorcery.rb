Rails.application.config.sorcery.submodules = [:remember_me, :reset_password]
Rails.application.config.sorcery.configure do |config|
  config.user_config do |user|
    user.downcase_username_before_authenticating = 'true'
    user.reset_password_mailer = UserMailer
    user.reset_password_email_method_name = :reset_password
    user.username_attribute_names = [:email]
  end
  config.user_class = 'User'
end

module Sorcery
  module Model
    module InstanceMethods
      def generic_send_email(method, mailer)
        config = sorcery_config
        mail = config.send(mailer).send(config.send(method),self).deliver_later
      end
    end
  end
end
