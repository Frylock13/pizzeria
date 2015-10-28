Rails.application.configure do
  config.action_controller.asset_host = 'http://localhost:3000'
  config.action_controller.perform_caching = false
  config.action_mailer.asset_host = 'http://localhost:3000/'
  config.action_mailer.default_url_options = { host: 'localhost', port: '3000' }
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.preview_path = "#{Rails.root}/lib/mailer_previews"
  config.action_mailer.raise_delivery_errors = false
  config.active_record.migration_error = :page_load
  config.active_support.deprecation = :log
  config.assets.debug = true
  config.cache_classes = false
  config.consider_all_requests_local = true
  config.eager_load = false
  config.log_level = :warn
  config.middleware.use Rack::LiveReload
  config.sass.inline_source_maps = true
  config.sass.line_comments = false
  config.sass.preferred_syntax = :sass
  config.after_initialize do
    Bullet.enable = true
    Bullet.alert = true
  end
end
