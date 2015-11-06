require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

module Pizzeria
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.autoload_paths += %W(
      #{config.root}/lib/validators
    )
    config.encoding = 'utf-8'
    config.i18n.available_locales = [:ru, :en]
    config.i18n.default_locale = :ru
  end
end
