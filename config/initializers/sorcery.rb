Rails.application.config.sorcery.submodules = [:remember_me, :reset_password, :external]
Rails.application.config.sorcery.configure do |config|
  config.external_providers = [:facebook, :google, :twitter, :vk]
  config.user_config do |user|
    user.authentications_class = Authentication
    user.downcase_username_before_authenticating = 'true'
    user.reset_password_mailer = UserMailer
    user.reset_password_email_method_name = :reset_password
    user.username_attribute_names = [:email]
  end
  config.user_class = 'User'
  config.facebook.callback_url = 'http://www.vpzven.ru/oauth/callback?provider=facebook'
  config.facebook.key = ENV['AUTH_FACEBOOK_KEY']
  config.facebook.secret = ENV['AUTH_FACEBOOK_SECRET']
  config.google.callback_url = 'http://www.vpzven.ru/oauth/callback?provider=google'
  config.google.key = ENV['AUTH_GOOGLE_KEY']
  config.google.secret = ENV['AUTH_GOOGLE_SECRET']
  config.twitter.callback_url = 'http://www.vpzven.ru/oauth/callback?provider=twitter'
  config.twitter.key = ENV['AUTH_TWITTER_KEY']
  config.twitter.secret = ENV['AUTH_TWITTER_SECRET']
  config.vk.callback_url = 'http://www.vpzven.ru/oauth/callback?provider=vk'
  config.vk.key = ENV['AUTH_VK_KEY']
  config.vk.secret = ENV['AUTH_VK_SECRET']
end

module Sorcery
  module Model
    module InstanceMethods
      def generic_send_email(method, mailer)
        config = sorcery_config
        config.send(mailer).send(config.send(method), self).deliver_later
      end
    end
  end
end
